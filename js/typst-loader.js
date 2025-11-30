(() => {
  var __create = Object.create;
  var __defProp = Object.defineProperty;
  var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
  var __getOwnPropNames = Object.getOwnPropertyNames;
  var __getProtoOf = Object.getPrototypeOf;
  var __hasOwnProp = Object.prototype.hasOwnProperty;
  var __require = /* @__PURE__ */ ((x) => typeof require !== "undefined" ? require : typeof Proxy !== "undefined" ? new Proxy(x, {
    get: (a, b) => (typeof require !== "undefined" ? require : a)[b]
  }) : x)(function(x) {
    if (typeof require !== "undefined") return require.apply(this, arguments);
    throw Error('Dynamic require of "' + x + '" is not supported');
  });
  var __copyProps = (to, from, except, desc) => {
    if (from && typeof from === "object" || typeof from === "function") {
      for (let key of __getOwnPropNames(from))
        if (!__hasOwnProp.call(to, key) && key !== except)
          __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
    }
    return to;
  };
  var __toESM = (mod, isNodeMode, target) => (target = mod != null ? __create(__getProtoOf(mod)) : {}, __copyProps(
    // If the importer is in node compatibility mode or this is not an ESM
    // file that has been converted to a CommonJS file using a Babel-
    // compatible transform (i.e. "__esModule" has not been set), then set
    // "default" to the CommonJS "module.exports" for node compatibility.
    isNodeMode || !mod || !mod.__esModule ? __defProp(target, "default", { value: mod, enumerable: true }) : target,
    mod
  ));

  // <stdin>
  var TypstLoader = class {
    constructor() {
      this.initialized = false;
      this.renderer = null;
    }
    async initialize() {
      if (this.initialized) return;
      try {
        const { initRenderer } = await import("https://unpkg.com/@myriaddreamin/typst.ts@latest/dist/esm/renderer.mjs");
        this.renderer = await initRenderer();
        this.initialized = true;
        console.log("Typst\u6E32\u67D3\u5668\u521D\u59CB\u5316\u6210\u529F");
      } catch (error) {
        console.error("Typst\u6E32\u67D3\u5668\u521D\u59CB\u5316\u5931\u8D25:", error);
      }
    }
    showLoading(container) {
      container.innerHTML = `
        <div class="loading-state">
        <div class="spinner"></div>
        <p>\u6B63\u5728\u6E32\u67D3Typst\u5185\u5BB9...</p>
        </div>
        `;
    }
    showError(container, message) {
      container.innerHTML = `
        <div class="error-state">
        <strong>\u26A0\uFE0F \u6E32\u67D3\u5931\u8D25</strong>
        <p>${message}</p>
        <button onclick="window.location.reload()">\u91CD\u8BD5</button>
        </div>
        `;
    }
    async renderTypstFile(containerId, filePath) {
      if (!this.initialized) {
        await this.initialize();
      }
      const container = document.getElementById(containerId);
      if (!container) {
        console.error(`\u5BB9\u5668 ${containerId} \u672A\u627E\u5230`);
        return;
      }
      this.showLoading(container);
      try {
        const response = await fetch(filePath);
        if (!response.ok) {
          throw new Error(`\u6587\u4EF6\u52A0\u8F7D\u5931\u8D25: ${response.status}`);
        }
        const typstSource = await response.text();
        container.innerHTML = "";
        await this.renderer.render(container, typstSource);
      } catch (error) {
        this.showError(container, error.message);
      }
    }
  };
  window.typstLoader = new TypstLoader();
})();
