#!/bin/bash

set -e

#############################################
# 🚀 Build e Instalação da Wheel do PyTorch
# 🔥 Compatível com: Ubuntu/Debian, RTX 5070+
# 📅 Atualizado: Maio 2025
#############################################

# 🔧 Configurações do ambiente
WORKSPACE=~/
PYTORCH_DIR=$WORKSPACE/pytorch
DIST_DIR=$WORKSPACE/dist
VENV_PROJETO="$WORKSPACE/projetos/projeto1/venv"  # 🔥 Altere para seu projeto!

echo "🚀 Iniciando build da wheel do PyTorch..."

# 🛠️ Ativar o venv usado para compilação do PyTorch
source $WORKSPACE/venv_pytorch_build/bin/activate

# 🔻 Entrar na pasta do PyTorch
cd $PYTORCH_DIR

# 🧹 Limpeza anterior (opcional mas recomendado)
python setup.py clean

# 📦 Garantir que o pacote build está instalado
pip install --upgrade build

# 🏗️ Gerar a wheel
python -m build --wheel

# 🚚 Criar pasta dist se não existir
mkdir -p $DIST_DIR

# 🔥 Copiar a wheel para a pasta dist organizada
cp dist/torch-*.whl $DIST_DIR

echo "✅ Wheel criada e movida para $DIST_DIR"

# 📥 Ativar o venv do projeto onde deseja instalar
echo "🔧 Instalando no venv do projeto: $VENV_PROJETO"
source $VENV_PROJETO/bin/activate

# 🧠 Instalar ou reinstalar a wheel do PyTorch
pip install --force-reinstall $DIST_DIR/torch-*.whl

pip install --force-reinstall ~/pytorch/dist/torch-2.8.0a0+gitf55f2f4-cp312-cp312-linux_x86_64.whl

echo "✅ Wheel do PyTorch instalada no venv do projeto!"

# ✔️ Verificar instalação
python -c "import torch; print('🚀 PyTorch versão:', torch.__version__); print('🔥 CUDA Disponível:', torch.cuda.is_available()); print('🖥️ GPU:', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'Nenhuma GPU detectada')"

echo "🏁 Processo concluído com sucesso."
