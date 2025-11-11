You can use any custom model to run the benchmark by inheriting from the `thunder.models.PretrainedModel` class.

!!!note
    A few examples of such files described bellow can be found in the `examples` folder of the repository.

To do so you will need to prepare a `.py` with a class definition of your model that inherits from `thunder.models.PretrainedModel` and overrides the following methods:

- `get_transform`: This method should return a transform function that will be used to preprocess the input data. The transform function should take a single argument, which is the input data, and return the transformed data.
- `get_linear_probing_embeddings`: This method should return the embeddings for the linear probing task. It should take a single argument, which is the input data, and return the embeddings (bs, emb_size).
- `get_segmentation_embeddings`: This method should return the embeddings for the segmentation task. It should take a single argument, which is the input data, and return the embeddings (bs, tokens, emb_size).

Additionally two properties should be available in the class: 

- `name`: This property should return the name of the model.  
- `emb_dim`: This property should return the embedding dimension of the model.

Here is an example of such a file:

```python
# my_model.py
from thunder.models import PretrainedModel

class DINOv2Features(PretrainedModel):
    def __init__(self):
        super().__init__()
        
        import torch
        from torchvision import transforms

        self.dinov2 = torch.hub.load("facebookresearch/dinov2", "dinov2_vits14")
        self.t = transforms.Compose(
            [
                transforms.ToTensor(),
                transforms.Resize((224, 224)),
            ]
        )
        self.name = "dinov2_vits14"
        self.emb_dim = 384
        self.vlm = False

    def forward(self, x):
        feats = self.dinov2.forward_features(x)
        return feats

    def get_transform(self):
        return self.t

    def get_linear_probing_embeddings(self, x):
        x = self.dinov2.forward_features(x)
        return x["x_norm_clstoken"]
    
    def get_segmentation_embeddings(self, x):
        x = self.dinov2.forward_features(x)
        return x['x_norm_patchtokens']
```

With this file ready, you can run any benchmark task using the following command:

```console
thunder benchmark custom:/path/to/my_model.py db_name task_name
```

or through the API:

```python
from thunder import benchmark
from my_model import DINOv2Features

if __name__ == "__main__":
    model = DINOv2Features()
    benchmark(model, dataset="ccrcc", task="linear_probing")
```
