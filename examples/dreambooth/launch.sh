#export MODEL_NAME="/home/vazzda/sd/_models/runwayml/stable-diffusion-v1-5"
export MODEL_NAME="/home/vazzda/sd/_models/Deliberate"
export VAE_NAME="/home/vazzda/sd/_models/stabilityai/sd-vae-ft-mse-original"
export OUTPUT_DIR="/mnt/c/_wrk/SD/__target/_results"

accelerate launch train_dreambooth.py \
  --pretrained_model_name_or_path=$MODEL_NAME \
  --pretrained_vae_name_or_path="$VAE_NAME" \
  --output_dir=$OUTPUT_DIR \
  --revision="fp16" \
  --with_prior_preservation --prior_loss_weight=1.0 \
  --seed=234425310 \
  --resolution=512 \
  --train_batch_size=1 \
  --train_text_encoder \
  --mixed_precision="fp16" \
  --use_8bit_adam \
  --gradient_checkpointing \
  --gradient_accumulation_steps=1 \
  --learning_rate=1e-6 \
  --lr_scheduler="constant" \
  --lr_warmup_steps=0 \
  --num_class_images=60 \
  --sample_batch_size=1 \
  --n_save_sample=5 \
  --max_train_steps=4000 \
  --save_interval=5 \
  --concepts_list="concepts_list.json" \
  --sanity_list="sanity_list.json" \
  --save_sample_prompt="shoulnt be in use, cause of sanily list" \
#  --read_prompts_from_txts

