import { app, BrowserWindow, ipcMain } from "electron";
import { fileURLToPath } from "url";
import { dirname, join } from "path";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

let win;

function createWindow() {
  win = new BrowserWindow({
    width: 477,
    height: 398,
    frame: true,
    autoHideMenuBar: true,
    minimizable: true,
    maximizable: false,
    resizable: false,
    webPreferences: {
      preload: join(__dirname, "preload.js"),
      nodeIntegration: false,
      contextIsolation: true
    }
  });

  // URL do seu UniGUI
  win.loadURL("http://localhost:8077");
  win.center();

  // win.webContents.openDevTools({ mode: "detach" });

  ipcMain.on("after-login", (event, obj) => {
    if (!win) return;
    win.setResizable(true);
    win.setMaximizable(true);
    win.setSize(obj.w, obj.h);
    win.center();
  });
}

app.whenReady()
  .then(createWindow)
  .catch(err => console.error("Erro ao iniciar app:", err));

app.on("activate", () => {
  if (BrowserWindow.getAllWindows().length === 0) createWindow();
});