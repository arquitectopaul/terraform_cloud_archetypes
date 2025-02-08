# Creating the IP Set tp be defined in AWS WAF  
resource "aws_waf_ipset" "ipset" {
  name = var.waf_ipset_name
  ip_set_descriptors {
    type  = "IPV4"
    value = "10.112.0.0/20"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "10.113.0.0/20"
  }
}

# Creating the AWS WAF rule that will be applied on AWS Web ACL
resource "aws_waf_rule" "waf_rule" {
  depends_on = [aws_waf_ipset.ipset]

  name        = "${local.resource_name_preffix}${var.custom_waf_rule_resource_code}${local.resource_name_suffix}"
  metric_name = "${local.resource_name_preffix}${var.custom_waf_rule_metric_resource_code}${local.resource_name_suffix}"

  predicates {
    data_id = aws_waf_ipset.ipset.id
    negated = var.waf_predicates_negated
    type    = var.waf_predicates_type
  }
}

# Creating the Rule Group which will be applied on  AWS Web ACL
resource "aws_waf_rule_group" "rule_group" {
  name        = "${local.resource_name_preffix}${var.custom_waf_rule_group_resource_code}${local.resource_name_suffix}"
  metric_name = "${local.resource_name_preffix}${var.custom_waf_rule_metric_resource_code}${local.resource_name_suffix}"

  activated_rule {
    action {
      type = var.waf_activated_rule_action
    }
    priority = var.waf_activated_rule_priority
    rule_id  = aws_waf_rule.waf_rule.id
  }
}

# Creating the Web ACL component in AWS WAF
resource "aws_waf_web_acl" "waf_acl" {
  depends_on = [
    aws_waf_rule.waf_rule,
    aws_waf_ipset.ipset,
  ]

  name        = "${local.resource_name_preffix}${var.custom_web_acl_resource_code}${local.resource_name_suffix}"
  metric_name = "${local.resource_name_preffix}${var.custom_web_acl_metric_resource_code}${local.resource_name_suffix}"

  default_action {
    type = var.waf_default_action_type
  }

  rules {
    action {
      type = var.waf_rules_action_type
    }
    priority = var.waf_rules_priority
    rule_id  = aws_waf_rule.waf_rule.id
    type     = var.waf_rules_type
  }
}
