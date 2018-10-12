import boto3

def rds_info():
    client = boto3.client('rds')
    response = client.describe_db_instances()
    print("------------------------------------" + "\nRDS")
    print(response['DBInstances'][0])

    print("Security Group")
    security_group = client.describe_db_security_groups()
    print(security_group)



def eb_info():
    client = boto3.client('elasticbeanstalk')

    print("------------------------------------" + "\nEB")
    print("Applications")
    app = client.describe_applications()
    info = str((app['Applications'][0]))
    print(info)

    print("Environments")
    info = client.describe_environments()
    print(info)

def ec_info():
    client = boto3.client('elasticache')

    print("------------------------------------" + "\nElastiCache")
    print("cluters")
    info = client.describe_cache_clusters()
    print(info)

def vpc():
    print("------------------------------------" + "\nVPC")
    ec2 = boto3.resource('ec2')
    vpc = ec2.Vpc('vpc-0091268fa4e71a72e')
    print("cidr_block" + vpc.cidr_block) # the cidr block of vpc
    print("subnets")
    for subnet in vpc.subnets.all():
        print(subnet.cidr_block) # cidr block of three subnets in vpc
        print(subnet.available_ip_address_count) #
        for instance in subnet.instances.all():
            print(instance.tags)
            print(instance.security_groups)


if __name__ == '__main__':
    rds_info()
    eb_info()
    ec_info()
    vpc()
