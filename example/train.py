import hydra
from omegaconf import DictConfig
from hydra import slurm_utils
import os

@hydra.main(config_path='./config.yaml')
def train(cfg: DictConfig):
    print(cfg.pretty())

if __name__ == "__main__":
    train()
