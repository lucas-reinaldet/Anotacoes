// Como a palavra class é uma palavra reservada, ao definir class das tags HTML, é 
// convenção usar o atributo className

import "./Card.css"
import React from "react";

export default props => {
    return (
        <div className="Card">
            <div>{props.titulo}</div>
            <div>{props.conteudo}</div>
        </div>
    )
}