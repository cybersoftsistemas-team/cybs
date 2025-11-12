import { app, BrowserWindow, ipcMain } from 'electron';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

// Corrige __dirname em módulos ESM
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Função para criar a janela principal
function createWindow() {
  const win = new BrowserWindow({
    width: 452,
    height: 349,
    frame: false,
    autoHideMenuBar: true,
    minimizable: true,
    maximizable: false,
    resizable: false,
    webPreferences: {
      preload: join(__dirname, 'preload.js'),
      nodeIntegration: false,
      contextIsolation: true
    }
  });

  win.loadURL('http://localhost:8077');
  win.center();

  // win.webContents.openDevTools({ mode: 'detach' });
}

// Evento principal do ciclo de vida
app.whenReady()
  .then(createWindow)
  .catch(err => console.error('Erro ao iniciar app:', err));

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) createWindow();
});

ipcMain.on('window-close', () => win.close());
ipcMain.on('window-minimize', () => win.minimize());