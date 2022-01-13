// Criando components!
// Existe componentes baseados em funções e em classes!

// Componentes funcionais (Baseados em Funções):

// Como convenção, todos os componentes possuem a primeira
// letra do nome do arquivo em Maiusculo.
// Os componentes podem possuir a extensão JS ou JSX

// Exemplo:
// PrimeiroComponente.jsx

export default function Primeiro() {
    return 'Primeiro Componente!'
}

// Observação: Para que a função esteja disponivel para acesso
// externo, é necessário acrescentar o "export".

// Sempre que é export default, não é necessáriamente
// que o nome referenciado em "import Componente"
// Exemplo:

import Primeiro from './components/basics/Primeiro'

// seja exatamente o mesmo nome da função.
// Também é possivel, tornar essa função default "anonima"

export default function () {
    return 'Primeiro Componente!'
}

// Acessando componente em seu arquivo index.js

import ReactDOM from 'react-dom'
import React from 'react'
import Primeiro from './components/basics/Primeiro'

const el = document.getElementById('root')

var cont = 'Olá React!'

ReactDOM.render(<div>
    <Primeiro></Primeiro>
</div>, el)

// Utilizando jsx em components
// Observação, o import React pode não ser necessário.
import React from "react"

export default function Primeiro() {
    return <h2>Primeiro Componente com JSX!</h2>
}

// Quando se quer colocar o conteudo identado, pode acrescentar
// o mesmo dentro de porenteses.
// Observação: A necessidade de colocar entre parenteses
// pode não ser necessário.
export default function Primeiro() {

    return (
        <div>
            <h2>Primeiro Componente com JSX!</h2>
        </div>
    )
}

// Versão utilizada!
export default function Primeiro() {
    var msg = 'Seja bem vindo(a)!'
    return <div>
        <h2>Primeiro Componente com JSX!</h2>
        <p>{msg}</p>
    </div>
}

// Passando parametro para componentes
// As propriedades passadas aos componentes, não podem ser alteradas
// gerando erro caso ocorra a tentativa.

// Observação: Por convenção, se é usado o nome "props" para
// definir os parametros que serão recebidos

export default function (props) {
    console.log(props)
    var status1 = props.nota1 >= 7 ? 'Aprovado' : 'Recuperação'
    var status2 = props.nota2 >= 7 ? 'Aprovado' : 'Recuperação'
    return (
        <div>
            <h2> {props.titulo} </h2>
            <h3> {props.aluno} tem como nota: </h3>
            <p>Nota 01: {props.nota1} está {status1} <br />
                Nota 02:  {props.nota2} está {status2}</p>
        </div>
    )
}

// Passando os parametros para o componente:

<ComParametro
    titulo='Titulo via Parametro!'
    aluno='Nota do Aluno!'
    nota1={9.2}
    nota2="10.0"
/>

// Exemplo:

import './index.css'
import ReactDOM from 'react-dom'
import React from 'react'
import Primeiro from './components/basics/PrimeiroComponente'
import ComParametro from './components/basics/ComParametro'

const el = document.getElementById('root')

var cont = 'Olá React!'

ReactDOM.render(<div>
    <Primeiro></Primeiro>
    <ComParametro
        titulo='Titulo via Parametro!'
        aluno='Nota do Aluno!'
        nota1={9.2}
        nota2="10.0"
    />
</div>, el)

    // Passando a nota entre chaves, o browser identifica como numerico.
    // entretanto ao realizar uma validação da nota como inteira, 
    // não ocorreu nenhum erro de tipagem.

    // Observações:

    // O componente pode ser usador indefinitamente.

    // Pode-se fechar a tag com a "/" no final
    // Exemplo: <Primeiro/>
    // ou fechar de forma tradicional.
    // Exemplo: <Primeiro></Primeiro>

    // Quando se retorna mais de dois elementos sem um componente/tag que o envolve, 
    // é gerado um erro.

    // Exemplo:
    `
export default function Fragmento(props) {
    return (
        <h2>Fragmento!!!</h2>
        <h3>Será gerado o erro!!!</h3>
    )
}
`
// Sendo necessário ter uma tag ou um fragmento envolvendo todo o conteudo.
// Exemplo:

export default function Fragmento(props) {
    return <div>
        <h2>Fragmento!!!</h2>
        <h3>Será gerado o erro!!!</h3>
    </div>
}

// Uma outra maneira de se resolver esse problema é:

import React from "react"

export default function Fragmento(props) {
    return <React.Fragment>
        <h2>Fragmento!!!</h2>
        <h3>Será gerado o erro!!!</h3>
    </React.Fragment>
}

// ou

export default function Fragmento(props) {
    return <>
        <h2>Fragmento!!!</h2>
        <h3>Será gerado o erro!!!</h3>
    </>
}

// Nos dois exemplos anteriores, os elementos serão apresentados de forma "solta" no browser
// não contendo nenhum componente "master" que agrupe esses dois elementos.

// Formas de declarar fucntions

// Função Anonima
export default function (props) {
    return (
        <div id="app">
        </div>
    )
}

// Arrow function
export default (props) => {
    return (
        <div id="app">
        </div>
    )
}

// Arrow function
export default props => {
    return (
        <div id="app">
        </div>
    )
}

// Arrow function
// Sem parametros
export default () => {
    return (
        <div id="app">
        </div>
    )
}

// Arrow function
// _ simboliza que o parametro não me interessa
export default _ => {
    return (
        <div id="app">
        </div>
    )
}

// Arrow function
// _ simboliza que o parametro não me interessa
// Forma mais reduzida de criar uma função
export default _ =>
    <div id="app">
    </div>
