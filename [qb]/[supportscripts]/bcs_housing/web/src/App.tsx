import { useState } from 'react';
import './App.css';

import { useExitListener } from './hooks/useExitListener';
import { useNuiEvent } from './hooks/useNuiEvent';
import { debugData } from './utils/debugData';
import { fetchNui } from './utils/fetchNui';

import CreateHome from './pages/CreateHome';
import BuyHome from './pages/BuyHome';
import MortgageStatus from './pages/MortgageStatus';
import Selection from './components/Selection';
import { HelpNotification } from './components/HelpNotification';
import { locale } from './store/locale';

debugData([
  {
    action: 'display',
    data: {
      display: 'creator',
    },
  },
]);

function App() {
  const [display, setDisplay] = useState('');

  const handleClose = () => {
    setDisplay('');
    fetchNui('hideFrame');
  };

  fetchNui<{ [key: string]: string }>('initialize').then((data) => {
    for (const [name, str] of Object.entries(data.locale)) locale[name] = str;
  });

  useNuiEvent('display', (data) => {
    setDisplay(data.display);
  });

  useExitListener(handleClose);

  const displayPage = () => {
    switch (display) {
      case 'creator':
        return <CreateHome handleClose={handleClose} />;
      case 'buy':
        return <BuyHome handleClose={handleClose} />;
      case 'mortgage':
        return <MortgageStatus handleClose={handleClose} />;
      case 'selection':
        return <Selection handleClose={handleClose} />;
      default:
        return <></>;
    }
  };

  return (
    <>
      <HelpNotification />
      <div className="flex h-screen font-PFDinDisplayPro">{displayPage()}</div>
    </>
  );
}

export default App;
