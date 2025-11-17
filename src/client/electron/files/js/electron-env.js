if (typeof window.electronEnv === "undefined") {
  window.electronEnv = { isElectron: false };
}

if (typeof window.electronAPI === "undefined") {
  window.electronAPI = {
    on: function () {
      /* vazio */
    },
    send: function () {
      /* vazio – não faz nada na web */
    },
  };
}
