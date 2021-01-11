resource "aws_sns_topic" "myasg-sns" {
  name              = "myasg-sns"
  display_name      = "myasg-sns"
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "myasg-sns-subscribe" {
  topic_arn = aws_sns_topic.myasg-sns.arn
  protocol  = "email"
  endpoint  = "zigz5638@gmail.com"
}