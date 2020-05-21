resource "aws_ecs_cluster" "ck-cluster" {
    name = "ck-cluster"
}

# ECS タスクの定義
resource "aws_ecs_task_definition" "ck-task-definition" {
    family                      = "ck-task-definition"
    cpu                         = "256"
    memory                      = "512"
    network_mode                = "awsvpc"
    requires_compatibilities    = ["FARGATE"]
    container_definitions       = file("./container_definitions.json")
    execution_role_arn          = module.ecs_task_execution_role.iam_role_arn
}

# ECS サービスの定義
resource "aws_ecs_service" "ck-service" {
    name                                = "ck-service"
    cluster                             = aws_ecs_cluster.ck-cluster.arn
    task_definition                     = aws_ecs_task_definition.ck-task-definition.arn
    desired_count                       = 2
    launch_type                         = "FARGATE"
    platform_version                    = "1.3.0"
    health_check_grace_period_seconds   = 60

    network_configuration {
        assign_public_ip = false
        security_groups  = [module.nginx_sg.security_group_id]

        subnets = [
            aws_subnet.private_0.id,
            aws_subnet.private_1.id,
        ]
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.ck-ab-target.arn
        container_name   = "chellskitchen-nginx"
        container_port   = 80
    }

    lifecycle {
        ignore_changes = [task_definition]
    }

    depends_on = [aws_lb_target_group.ck-ab-target]
}

module "nginx_sg" {
    source      = "./security_group"
    name        = "nginx-sg"
    vpc_id      = aws_vpc.chells_kitchen.id
    port        = 80
    cidr_blocks = [aws_vpc.chells_kitchen.cidr_block]
}

# CloudWatch Logsの定義
resource "aws_cloudwatch_log_group" "for_ecs" {
    name                = "/ecs/chellskitchen-logs"
    retention_in_days   = 180
}

# AmazonECSTaskExecutionRolePolicyの定義(CloudWatch Logsの操作権限をECSに与える)
data "aws_iam_policy" "ecs_task_execution_role_policy" {
    arn = "arn:aws:iam::aws:policy/serrvice-role/AmazonECSTaskExexutionRolePolicy"
}

# ECSタスク実行IAMロールのポリシードキュメントの定義
data "aws_iam_policy_document" "ecs_task_execution" {
    source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

    statement {
        effect      = "Allow"
        actions     = ["ssm:GetParameters", "kms:Decrypt"]
        resources   = ["*"]
    }
}

module "ecs_task_execution_role" {
    source      = "./iam_role"
    name        = "ecs-task-execution"
    identifier  = "ecs-tasks.amazonaws.com"
    policy      = data.aws_iam_policy_document.ecs_task_execution.json
}