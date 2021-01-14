resource "aws_sns_topic" "myasg-sns" {
  name              = "myasg-sns"
  display_name      = "myasg-sns"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "myasg-sns-subscribe" {
  topic_arn = aws_sns_topic.myasg-sns.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.myasg-queue.arn
}

resource "aws_sqs_queue" "myasg-queue" {
  name                              = "myasg-queue"
  delay_seconds                     = 90
  max_message_size                  = 2048
  message_retention_seconds         = 86400
  receive_wait_time_seconds         = 10
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300

  tags = {
    Environment = "production"
  }
}