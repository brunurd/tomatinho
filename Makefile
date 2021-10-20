STAGE := $(or ${STAGE}, "Dev")

tf_deploy:
	@./scripts/bash/tf_deploy.sh "$(STAGE)"

tf_destroy:
	@./scripts/bash/tf_destroy.sh "$(STAGE)"

sam_deploy:
	@./scripts/bash/sam_deploy.sh "$(STAGE)"
