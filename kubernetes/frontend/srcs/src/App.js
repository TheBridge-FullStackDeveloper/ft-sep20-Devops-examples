import {useEffect, useState} from "react"
import './App.css';

function App() {
	const [people, setpeople] = useState([])
	useEffect(() => {
		console.log(process.env)
		fetch(process.env.REACT_APP_backurl).then(d => d.json()).then(data => {
			console.log(data);
			setpeople(data.results);
		})
	}, [])
  return (
    <div className="App">
		{people && people.map(person => (
			<div>
				<p>{`${person.name.title} ${person.name.first} ${person.name.last}`}</p>
				<img src={person.picture.large} alt="avatar"/>
			</div>
		))}
    </div>
  )
}

export default App;
