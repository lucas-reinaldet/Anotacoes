// Para se passar componentes para outros Componentes, existe uma propriedade chamada
// children, onde todo o conteudo passado entre a TAG 
// <Tag> Aqui fica o conteudo entre as tags </Tag>
// Não existe nenhum limite quanto ao conteudo passado
// Exemplo:

import React from "react";
import Card from "./components/layout/Card";
import Aleatorio from "./components/basics/Aleatorio";

export default _ =>
    <Card
        titulo="Titulo do Card!!!">
        <div id="app">
            <Aleatorio min={1} max={60}></Aleatorio>
            <Aleatorio min={1} max={60}></Aleatorio>
            <Aleatorio min={1} max={60}></Aleatorio>
        </div>
    </Card>

// Arquivo Card.jsx

import "./Card.css"
import React from "react";

export default props => {
    return (
        <div className="Card">
            <div className="Title"><h1>{props.titulo}</h1></div>
            <div className="Content">{props.children}</div>
        </div>
    )
}

// Arquivo Aleatorio.jsx

import React from "react"

export default props => {

    const { min, max } = props
    const value = parseInt(Math.random() * (max - min)) + min
    
    return <div>
        <h2>Valor Aleatório:</h2>
        <p><strong>Valor minimo: </strong> {min}</p>
        <p><strong>Valor Máximo: </strong> {max}</p>
        <p><strong>Valor sorteado: </strong> {value}</p>
    </div>
}

