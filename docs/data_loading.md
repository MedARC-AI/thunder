The `online_loading`, `image_pre_loading` and `embedding_pre_loading` settings are only related to the `linear_probing` and `segmentation` tasks (only tasks involving some training -- either linear probe or segmentation decoder), and should not have an impact on the final performance. We provide this `--loading-mode` flag to give more flexibility to the user in terms of the data loading:

* `online_loading`: batch images are loaded online during training and you perform encoder forward passes.
* `image_pre_loading`: all images are first loaded into RAM and you also perform encoder forward passes.
* `embedding_pre_loading`: pre-computed embeddings are loaded and no forward pass with the encoder is performed. **Requires to first have pre-computed embeddings with the `pre_computing_embeddings` task.**

`online_loading` and `image_pre_loading` might be needed in special cases, e.g. if you want to do some LoRA adaptation of the encoder. However, if your goal is to do standard linear probing evaluation, we would suggest to first pre-compute embeddings (e.g. `thunder benchmark h0mini patch_camelyon pre_computing_embeddings`), before to run `linear_probing` with `--loading-mode=embedding_pre_loading` (e.g. `thunder benchmark h0mini patch_camelyon linear_probing --loading-mode=embedding_pre_loading`) to speed up your experiments.
