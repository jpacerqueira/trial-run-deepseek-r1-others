#/bin/bash env
#
echo " TEST - https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-70B?local-app=vllm "
#
## DEPLOY IN LOCAL DOCKER
#
# Deploy with docker on Linux:
docker run --runtime nvidia --gpus all \
	--name my_vllm_container \
	-v ~/.cache/huggingface:/root/.cache/huggingface \
 	--env "HUGGING_FACE_HUB_TOKEN=<secret>" \
	-p 8000:8000 \
	--ipc=host \
	vllm/vllm-openai:latest \
	--model deepseek-ai/DeepSeek-R1-Distill-Llama-70B
#
## RUN
#
# Load and run the model:
docker exec -it my_vllm_container bash -c "vllm serve deepseek-ai/DeepSeek-R1-Distill-Llama-70B"
#
## TEST 
#
# Call the server using curl:
curl -X POST "http://localhost:8000/v1/chat/completions" \
	-H "Content-Type: application/json" \
	--data '{
		"model": "deepseek-ai/DeepSeek-R1-Distill-Llama-70B",
		"messages": [
			{
				"role": "user",
				"content": "What is the capital of France?"
			}
		]
	}'
#
