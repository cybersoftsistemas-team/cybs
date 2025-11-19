import { app, BrowserWindow, ipcMain, Tray, Menu } from "electron";
import { fileURLToPath } from "url";
import { dirname, join } from "path";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

let title;
let tray;
let win;

function createWindow() {
  win = new BrowserWindow({
    width: 467,
    height: 387,
    frame: true,
    autoHideMenuBar: true,
    minimizable: true,
    maximizable: false,
    resizable: false,
    icon: __dirname + "/files/icons/cbs.ico",
    webPreferences: {
      preload: join(__dirname, "preload.js"),
      nodeIntegration: false,
      contextIsolation: true,
    },
  });

  // URL do seu UniGUI
  win.loadURL("http://localhost:8077");
  win.center();

  // win.webContents.session.clearCache().then(() => {
  //   win.webContents.reloadIgnoringCache();
  // });

  // win.webContents.openDevTools({ mode: "detach" });

  win.setTitle("Cybersoft Sistemas");
  title = win.getTitle();

  // Linux precisa de PNG
  const trayIcon =
    process.platform === "linux"
      ? join(__dirname, "files/icons/cbs.png")
      : join(__dirname, "files/icons/cbs.ico");

  tray = new Tray(trayIcon);
  tray.setToolTip(title);

  const menu = Menu.buildFromTemplate([
    { label: "Abrir Configurações", click: () => win.show() },
    { type: "separator" },
    { label: `Fechar o ${title}`, click: () => app.quit() },
  ]);

  tray.setContextMenu(menu);

  // Use double-click (evita bloquear o menu no Linux)
  tray.on("double-click", () => {
    if (win.isVisible()) win.hide();
    else win.show();
  });

  ipcMain.on("after-login", (event, obj) => {
    if (!win) return;
    win.setResizable(true);
    win.setMaximizable(true);
    win.setSize(obj.w, obj.h);
    win.center();
  });
}

app
  .whenReady()
  .then(createWindow)
  .catch((err) => console.error("Erro ao iniciar app:", err));

app.on("activate", () => {
  if (BrowserWindow.getAllWindows().length === 0) createWindow();
});
