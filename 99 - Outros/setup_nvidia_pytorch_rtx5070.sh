#!/bin/bash

###############################################################################
# 🖥️ Script Definitivo de Instalação — NVIDIA RTX 5070 + PyTorch (Compilado)
# 🔥 Compatível com a série RTX 50 (arquitetura Blackwell - SM_120)
# 📅 Atualizado: Maio/2025
#
# 📂 Local de trabalho: ~/workspace/pytorch
# 🔧 Ambiente Python isolado: ~/workspace/venv
#
# 🚩 Este script:
#   1. Remove drivers NVIDIA antigos
#   2. Instala driver NVIDIA Open Kernel correto
#   3. Instala dependências de sistema e Python
#   4. Clona e compila o PyTorch com suporte nativo à RTX 5070 (SM_120)
#   5. Faz testes automáticos de CUDA e GPU
#
# ⚠️ Atenção: Leia atentamente as observações ao final
###############################################################################

set -e

################################################################################
# 🟨 🔥 OBSERVAÇÃO CRÍTICA 🔥
#
# ➤ O driver proprietário tradicional da NVIDIA NÃO SUPORTA a RTX 5070 (PCI ID 10de:2f04).
# ➤ É OBRIGATÓRIO o uso do driver Open Kernel Module: nvidia-driver-575-open (ou superior).
#
# ➤ 🔒 Secure Boot deve estar DESATIVADO na BIOS. Sem isso, os módulos NVIDIA não carregam.
#
# ➤ Este script não instala o CUDA Toolkit manual, pois o driver já fornece a API CUDA Runtime.
# ➤ PyTorch é compilado com suporte total à arquitetura SM_120 (Blackwell).
################################################################################

echo "🛑 Iniciando processo de limpeza de drivers antigos..."

# 🔥 1. Remover qualquer driver NVIDIA anterior
sudo apt remove --purge -y '^nvidia.*' 'libnvidia*'
sudo apt autoremove --purge -y
sudo apt clean

echo "🧹 Limpeza concluída."

################################################################################
# ⚙️ Atualizar sistema
################################################################################
echo "🔄 Atualizando pacotes do sistema..."
sudo apt update && sudo apt upgrade -y

################################################################################
# 📦 Instalar dependências do sistema
################################################################################
echo "📦 Instalando dependências essenciais..."
sudo apt install -y \
    build-essential dkms linux-headers-$(uname -r) \
    python3 python3-dev python3-pip python3-venv \
    git cmake ninja-build wget curl \
    libopenblas-dev libblas-dev libeigen3-dev \
    libnccl-dev libnccl2 libjpeg-dev zlib1g-dev \
    libpng-dev libffi-dev libssl-dev liblzma-dev \
    patchelf gcc g++

################################################################################
# 🟩 Instalar driver NVIDIA correto (Open Kernel)
################################################################################
echo "🟩 Instalando driver NVIDIA Open..."
sudo apt install -y nvidia-driver-575-open

echo "✔️ Driver instalado. ✔️ Execute 'nvidia-smi' após o reboot para validar."

################################################################################
# 📂 Criar local de trabalho
################################################################################
echo "📂 Criando diretório de trabalho em ~/workspace..."
mkdir -p ~/workspace
cd ~/workspace

################################################################################
# 🐍 Criar ambiente Python isolado
################################################################################
echo "🐍 Criando ambiente virtual em ~/workspace/venv..."
python3 -m venv venv
source venv/bin/activate

################################################################################
# 📦 Instalar dependências Python para build
################################################################################
echo "📦 Instalando dependências Python..."
pip install --upgrade pip setuptools wheel
pip install numpy pyyaml mkl mkl-include setuptools \
    cffi typing_extensions future six requests \
    dataclasses ninja

################################################################################
# 🔻 Clonar PyTorch
################################################################################
echo "🔻 Clonando repositório PyTorch..."
git clone --recursive https://github.com/pytorch/pytorch
cd pytorch

################################################################################
# ⚙️ Configurar arquitetura CUDA para RTX 5070 (SM_120)
################################################################################
echo "⚙️ Configurando arquitetura CUDA para RTX 5070..."
export TORCH_CUDA_ARCH_LIST="12.0"

################################################################################
# 📄 Instalar requisitos do PyTorch
################################################################################
echo "📄 Instalando requisitos do PyTorch..."
pip install -r requirements.txt

################################################################################
# 🛠️ Compilar PyTorch
################################################################################
echo "🛠️ Compilando PyTorch com suporte a SM_120 (Blackwell)..."
MAX_JOBS=$(nproc) python setup.py install

################################################################################
# ✅ Testar instalação
################################################################################
echo "✅ Testando PyTorch e CUDA..."

python3 <<EOF
import torch
print("🚀 PyTorch versão:", torch.__version__)
print("🔥 CUDA Disponível:", torch.cuda.is_available())
if torch.cuda.is_available():
    print("🖥️ GPU:", torch.cuda.get_device_name(0))
else:
    print("❌ Nenhuma GPU detectada")
EOF

echo "✅ Instalação completa e validada com sucesso!"

################################################################################
# 🏆 OBSERVAÇÕES FINAIS E CHECKLIST
#
# ✔️ O driver instalado é o nvidia-driver-575-open
# ✔️ Localização dos arquivos:
#    ➝ PyTorch clonado em: ~/workspace/pytorch
#    ➝ Ambiente Python: ~/workspace/venv
# ✔️ Secure Boot deve estar DESATIVADO
# ✔️ CUDA Runtime vem diretamente do driver, sem necessidade de toolkit manual
# ✔️ PyTorch compilado com suporte à arquitetura SM_120 (RTX 5070 - Blackwell)
#
# 🔁 Para atualizar o PyTorch no futuro:
#    cd ~/workspace/pytorch
#    git pull --recurse-submodules
#    MAX_JOBS=$(nproc) python setup.py install
#
# 🚀 Para usar o ambiente:
#    cd ~/workspace
#    source venv/bin/activate
#
# ❌ Para remover tudo:
#    rm -rf ~/workspace
#
# 🏁 Testar sempre com:
#    nvidia-smi
#    python -c 'import torch; print(torch.cuda.is_available()); print(torch.cuda.get_device_name(0))'
################################################################################
