variable "currency" {}
variable "monthly_billing_threshold" {}
variable "commontags" {}

resource "aws_cloudwatch_metric_alarm" "billing" {
  alarm_name          = "billing-alarm-${lower(var.currency)}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "28800"
  statistic           = "Maximum"
  threshold           = var.monthly_billing_threshold

  dimensions = {
    Currency = "${var.currency}"
  }
 tags = var.commontags
}
