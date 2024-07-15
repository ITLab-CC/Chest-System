'use client';
import { Loader } from '../../components/loader';
import { useState, useEffect } from 'react';
import { apiURL } from '../../utils/constants';
import CupboardsList from '../../components/CupboardsList';

export default function Cupboards() {

  const [loading, setLoading] = useState(true);
  const [cupboards, setCupboards] = useState([]);
  // const [searchTerm, setSearchTerm] = useState(''); //Suche möglich

//   useEffect(() => {
//     const onScroll = () => setOffset(window.scrollY);
//     // clean up code
//     window.removeEventListener('scroll', onScroll);
//     window.addEventListener('scroll', onScroll, { passive: true });
//     return () => window.removeEventListener('scroll', onScroll);
// }, []);

  async function getData() {
    setLoading(true);
    const resCupboards = await fetch(apiURL + '/cupboards');
    const cupboards = await resCupboards.json();
    setCupboards(cupboards);
    setLoading(false);
    console.log(cupboards);
  }
  
  useEffect(() => {
    getData();
  }, []);


  if (loading) {
    return <Loader/>;
  }
  const filteredCupboards = cupboards.filter((cupboards) =>
    cupboards.cupboard_name.toLowerCase() //.includes(searchTerm.toLowerCase())
  );

  return (
  <div>
      <nav className='menu menu-1'>
        <ul>
          <li>
            <a href='/'>Home</a>
          </li>
          <li>
            <a href='/cupboards'>Cupboards</a>
          </li>
        </ul>
      </nav>
      <h1 style={{ fontSize: '2.5em', color: '#00aeff', textAlign: 'center' }}>Cupboards</h1>
      <CupboardsList cupboards={filteredCupboards} />
  </div>
      );
}
