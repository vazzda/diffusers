#export MODEL_NAME="/home/vazzda/sd/_models/runwayml/stable-diffusion-v1-5"
#export MODEL_NAME="/home/vazzda/sd/_models/Deliberate"
#export MODEL_NAME="/home/vazzda/sd/models/DreamShaper3"
export MODEL_NAME="runwayml/stable-diffusion-v1-5"
export OUTPUT_DIR="/home/vazzda/sd/training"
#export SANITY_OUTPUT_DIR="/mnt/c/_wrk/sd/__target/_results"
export SANITY_OUTPUT_DIR="/home/vazzda/sd/training/_results"

accelerate launch train_dreambooth.py \
  --pretrained_model_name_or_path=$MODEL_NAME \
  --pretrained_vae_name_or_path="stabilityai/sd-vae-ft-mse" \
  --output_dir=$OUTPUT_DIR \
  --sanity_output_dir=$SANITY_OUTPUT_DIR \
  --revision="fp16" \
  --seed=3434554 \
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
  --sample_batch_size=1 \
  --n_save_sample=4 \
  --max_train_steps=3150 \
  --save_interval=200 \
  --save_first_step \
  --not_cache_latents \
  --concepts_list="concepts_list.json" \
  --save_sample_prompt="shoulnt be in use, cause of sanily list" \
  --sanity_list="sanity_list.json"

#  --save_first_step \
#  --sanity_list="sanity_list.json" \
#  --pretrained_vae_name_or_path="$VAE_NAME" \
#  --num_class_images=2000 \
#  --read_prompts_from_txts
#  --with_prior_preservation --prior_loss_weight=1.0 \
