Amazon EC2 Auto Scaling example
===============================

The following code creates an Auto Scaling group with scale-up and scale-down policies based on the monitoring the CPU utilization of either a specific EC2 instance or instances within the Auto Scaling group cluster.

If ``alarm_dimensions`` specifies ``InstanceId``, the Auto Scaling group will scale up or down according to the CPU utilization of the specified running instance; if ``alarm_dimensions`` specifies ``AutoScalingGroupName``, the Auto Scaling group will scale up or down according to the CPU utilization of instances within its existing cluster. For more metrics and dimensions in CloudWatch, see `Amazon Elastic Compute Cloud Dimensions and Metrics <http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/ec2-metricscollected.html>`_.

Raw code can be `downloaded here <https://raw.githubusercontent.com/moleculea/autoscale_sample/master/autoscale_sample.py>`_.


.. code-block:: python

    import boto.ec2
    from boto.ec2.autoscale import (AutoScalingGroup,
                                    LaunchConfiguration, ScalingPolicy)
    from boto.ec2.cloudwatch import MetricAlarm
     
     
    # Create connections to Auto Scaling and CloudWatch
    as_conn = boto.ec2.autoscale.connect_to_region("us-east-1")
    cw_conn = boto.ec2.cloudwatch.connect_to_region("us-east-1")
     
    # Name for auto scaling group and launch configuration
    as_name = "VM1"
     
    # Create launch configuration
    lc = LaunchConfiguration(name=as_name,
                             image_id="ami-76f0061f",  # AMI ID of your instance
                             key_name="your_key_name",
                             security_groups="your_group_name",
                             instance_type="t1.micro",
                             instance_monitoring=True)
     
    as_conn.create_launch_configuration(lc)
     
    # Create Auto Scaling group
    ag = AutoScalingGroup(group_name=as_name,
                          availability_zones=["us-east-1b"],
                          launch_config=lc, min_size=0,
                          max_size=2,
                          connection=as_conn)
     
    as_conn.create_auto_scaling_group(ag)
     
    # Create scaling policies
    scale_up_policy = ScalingPolicy(
        name='scale_up', adjustment_type='ChangeInCapacity',
        as_name=as_name, scaling_adjustment=1, cooldown=180)
     
    scale_down_policy = ScalingPolicy(
        name='scale_down', adjustment_type='ChangeInCapacity',
        as_name=as_name, scaling_adjustment=-1, cooldown=180)
     
    as_conn.create_scaling_policy(scale_up_policy)
    as_conn.create_scaling_policy(scale_down_policy)
     
    scale_up_policy = as_conn.get_all_policies(
        as_group=as_name, policy_names=['scale_up'])[0]
     
    scale_down_policy = as_conn.get_all_policies(
        as_group=as_name, policy_names=['scale_down'])[0]
     
    # Set dimensions for CloudWatch alarms
    # Monitor on a specific instance
    alarm_dimensions = {"InstanceId": "your_instance_id"}
     
    # Monitor instances within the Auto Scaling group cluster
    alarm_dimensions_as = {"AutoScalingGroupName": as_name}
     
    # Create metric alarms
    scale_up_alarm = MetricAlarm(
        name='scale_up_on_cpu_' + as_name, namespace='AWS/EC2',
        metric='CPUUtilization', statistic='Average',
        comparison='>', threshold="80",
        period='60', evaluation_periods=2,
        alarm_actions=[scale_up_policy.policy_arn],
        dimensions=alarm_dimensions)
     
    scale_down_alarm = MetricAlarm(
        name='scale_down_on_cpu_' + as_name, namespace='AWS/EC2',
        metric='CPUUtilization', statistic='Average',
        comparison='<', threshold="20",
        period='60', evaluation_periods=2,
        alarm_actions=[scale_down_policy.policy_arn],
        dimensions=alarm_dimensions)
     
    # Create alarms in CloudWatch
    cw_conn.create_alarm(scale_up_alarm)
    cw_conn.create_alarm(scale_down_alarm)

.. author:: default
.. categories:: none
.. tags:: Python,AWS
.. comments::
