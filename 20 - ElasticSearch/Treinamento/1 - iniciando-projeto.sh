
# Iniciar projeto
npm init -y

# Resultado esperado

{
  "name": "projeto",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "description": ""
}

# Instalar o Typescript
npm install typescript ts-node @types/node --save-dev

# Resultado esperado
added 20 packages, and audited 21 packages in 3s

found 0 vulnerabilities

# 
npx tsc --init

# Resultado esperado
Created a new tsconfig.json with:                                                                           
                                                                                                         TS 
  target: es2016
  module: commonjs
  strict: true
  esModuleInterop: true
  skipLibCheck: true
  forceConsistentCasingInFileNames: true


You can learn more at https://aka.ms/tsconfig

# 
npm install oracledb

# Resultado esperado
added 1 package, and audited 22 packages in 818ms

found 0 vulnerabilities

#
npm install --save-dev @types/express

# Resultado esperado
added 10 packages, and audited 32 packages in 2s

found 0 vulnerabilities

