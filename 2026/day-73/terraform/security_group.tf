resource "aws_default_vpc" "main" { }
resource "aws_security_group" "my_sg" {
    name = "Observability_sg"
    description = "Security Group for Obervability Server"
    vpc_id = aws_default_vpc.main.id
         
         #SSH
        ingress { 
           from_port   = "22"
           to_port     = "22"
           protocol    = "TCP"
           cidr_blocks = ["0.0.0.0/0"]
       }
         #HTTP

        ingress {
           from_port   = "80"
           to_port     = "80"
           protocol    = "TCP"
           cidr_blocks = ["0.0.0.0/0"]
       }
        # HTTPS
        ingress {
           from_port   = "443"
           to_port     = "443"
           protocol    = "TCP"
           cidr_blocks = ["0.0.0.0/0"]
       }
       # APPLICATION_PORT
        ingress {
           from_port   = "8080"
           to_port     = "8080"
           protocol    = "TCP"
           cidr_blocks = ["0.0.0.0/0"]
       }
       ingress {
           from_port   = "8000"
           to_port     = "8000"
           protocol    = "TCP"
           cidr_blocks = ["0.0.0.0/0"]
       }
       
       
       # NODE EXPORTER
        ingress {
           from_port   = "9100"
           to_port     = "9100"
           protocol    = "TCP"
           cidr_blocks = ["0.0.0.0/0"]
       }
       #PROMETHEUS
        ingress {
           from_port   = "9090"
           to_port     = "9090"
           protocol    = "TCP"
           cidr_blocks = ["0.0.0.0/0"]
       }
        #GRAFANA
        ingress {
         from_port   = "3000"
         to_port     = "3000"
         protocol    = "TCP"
         cidr_blocks = ["0.0.0.0/0"]
       }

       #ALL OUTBOUND TRAFFIC    
       egress {
         from_port   = 0
         to_port     = 0
         protocol    = "-1"
         cidr_blocks = ["0.0.0.0/0"]
       }



    tags = {
        Name = "Task-73"
    }
}