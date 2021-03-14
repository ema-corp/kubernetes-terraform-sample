## terraform
※ terraformディレクトリ上で行うこと
参考：[fnaoto/gcp-k8s-sample: sample project for gcp](https://github.com/fnaoto/gcp-k8s-sample)

### 初期化(GCS上のバケットにtfstateを作成)

```
./terraform.sh init <バケット名>
```

### dry-run

```
terraform plan --var-file=tfvars/sample.tfvars
```

### 適用

```
terraform apply --var-file=tfvars/sample.tfvars
```

### 削除

```
terraform destroy --var-file=tfvars/sample.tfvars
```

## kubernetes
※ kubernetesディレクトリ上で行うこと

### クラスターの認証情報を取得する

```
gcloud container clusters get-credentials <cluster name>
```

### 作業環境に名前付け

```
kubectl create ns sample-ns
```

### オブジェクトへの反映

```
kubectl apply -f ./
```
