// import logo from './logo.svg';
// import './App.css';

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.js</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }

// export default App;
// import { Component } from "react";

// class App extends Component {
//   render() {
//     return (
//       <div>
//           Hello World!
//       </div>
//     );
//   }
// }
// export default App;
import logo from './logo.svg';
import './App.css';
import React, {useState, useEffect} from 'react';


function App() {
  const [message, setMessage]=useState([]);
  useEffect(()=>{
    fetch("/example")
        .then((res)=>{
          return res.json();
        })
        .then((data)=>{
            setMessage(data);
        });
  },[]);
  return (
    <div className="App">
      <header className="App-header">
        // 기본코드
        <ul>
          {message.map((v,idx)=><li key={`${idx}-${v}`}>{v}</li>)}
        </ul>
      </header>
    </div>
  );
}

export default App;