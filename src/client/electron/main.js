import { app, BrowserWindow, ipcMain } from "electron";
import { fileURLToPath } from "url";
import { dirname, join } from "path";
import fs from "fs";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

let win;

function createWindow() {
  win = new BrowserWindow({
    width: 469,
    height: 387,
    frame: true,
    autoHideMenuBar: true,
    minimizable: true,
    maximizable: false,
    resizable: false,
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

  ipcMain.on("after-login", (event, obj) => {
    if (!win) return;
    win.setResizable(true);
    win.setMaximizable(true);
    win.setSize(obj.w, obj.h);
    win.center();
  });

  ipcMain.handle("save-client-data", async (event, fileName, data) => {
    const userDir = app.getPath("userData");
    const filePath = join(userDir, fileName);

    try {
      fs.writeFileSync(filePath, data);
      return { ok: true, filePath };
    } catch (e) {
      return { ok: false, error: e.message };
    }
  });

  ipcMain.handle("load-client-data", async (event, fileName) => {
    const userDir = app.getPath("userData");
    const filePath = join(userDir, fileName);

    if (!fs.existsSync(filePath)) {
      return null;
    }

    return fs.readFileSync(filePath, "utf8");
  });
}

// app.commandLine.appendSwitch("disable-http-cache");

app
  .whenReady()
  .then(createWindow)
  .catch((err) => console.error("Erro ao iniciar app:", err));

app.on("activate", () => {
  if (BrowserWindow.getAllWindows().length === 0) createWindow();
});
