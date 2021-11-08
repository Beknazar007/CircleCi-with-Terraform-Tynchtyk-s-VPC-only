
# CONFIG.YML
## 1)We have create config file this need  for circleci (automate)
   1. inside of this file file we should write jobs
   1. inside of this job we should paste image (hashicorp/terraform)
   1. after write steps name (build)
   
    version: 2.1

    jobs: 
      build:
        docker: 
          - image: hashicorp/terraform   # this terraform image to run our project 
        steps: 
          - checkout 
          - run:
              name: "init"
              command: terraform init 
          - run:
              name: "plan"
              command: terraform plan

      build2:
        docker: 
          - image: hashicorp/terraform   # this terraform image to run our project 
        steps:
          - checkout 
          - run:
              name: "init"
              command: terraform init 
          - run:
              name: "apply"
              command: terraform apply --auto-approve #we have to 




 
  ## 3)To run it we should have workflow inside of this workflow write job
    workflows: 
      build:
        jobs:
          - build
          - hold:
              type: approval 
              requires:
                - build
          - build2:
              requires: 
                - hold     
  >Here we have to approve our action by manually that we want to apply     
          

# Change from terminal        
> To Run from terminal we can open terminal and put this commands

       terraform init
       terraform plan
       terraform apply --auto-approve


