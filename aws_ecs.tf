resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-ecs-cluster"
}

data "template_file" "nginx_task" {
  template = "${file("aws_ecs_task/nginx.json")}"

  vars {
    app_name   = "${var.app_name}"
    aws_region = "${var.default_region}"
  }
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  container_definitions    = "${data.template_file.nginx_task.rendered}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = "${aws_iam_role.ecs_task_role.arn}"
  cpu                      = 256
  memory                   = 512

  depends_on = [
    "aws_cloudwatch_log_group.nginx",
  ]
}
