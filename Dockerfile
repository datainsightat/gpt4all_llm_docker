

curl https://the-eye.eu/public/AI/models/nomic-ai/gpt4all/gpt4all-lora-quantized.bin -o gpt4all-lora-quantized.bin

git clone https://github.com/nomic-ai/gpt4all.git

mv gpt4all-lora-quantized.bin gpt4all/chat/

cd chat
./gpt4all-lora-quantized-linux-x86
