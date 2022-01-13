// Para se usar a sintaxe JSX, é necessário realizar
// a importação do REACT 

import React from 'react'

// Desta maneira, é possivel "emitir" Tags HTML para ser
// renderizada no browser. 
// Exemplo:

import ReactDOM from 'react-dom'
import React from 'react'

const el = document.getElementById('root')

var cont = 
    <div>
        <strong>Olá React!</strong>
    </div>

ReactDOM.render(cont, el)

// Desta maneira, o "Olá React!" será apresentado no browser
// dentro de uma div.

// Caso queira colocar o valor de uma variavel dentro da tag HTML
// é necessário colocar a variavel entre chaves ({})

var cont = 'Olá React!'
    
ReactDOM.render(<div>
                    <strong>{ cont }</strong>
                </div>, el)

//  Realizando a importação de um arquivo css que se encontra
// na mesma pasta.

import './index.css'
