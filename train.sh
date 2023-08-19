cd src/nr
CUDA_VISIBLE_DEVICES=$1 python run_training.py --cfg /workspaces/GraspNeRF/src/nr/configs/nrvgn_sdf.yaml
cd -
