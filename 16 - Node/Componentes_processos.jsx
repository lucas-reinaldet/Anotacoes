// Realizando algum tipo de calculo dentro da function

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