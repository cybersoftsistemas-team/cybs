const { contextBridge, ipcRenderer } = require("electron");

contextBridge.exposeInMainWorld("electronAPI", {
  on: (channel, callback) => {
    ipcRenderer.on(channel, (event, data) => callback(data));
  },
  send: (channel, data) => {
    ipcRenderer.send(channel, data);
  },
});

contextBridge.exposeInMainWorld("electronEnv", {
  isElectron: true,
});