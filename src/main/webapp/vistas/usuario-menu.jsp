<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover" />
  <title>SensePad · Configuración</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@3.19.0/dist/tabler-icons.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/estilos/styles.css" />
</head>
<body>

  <div class="wizard">

    <jsp:include page="_header-usuario.jsp" />

    <main class="wizard-main">
      <div class="visually-hidden" id="live" aria-live="polite" role="status"></div>

      <div class="wizard-ctx" id="w-ctx">Menú principal</div>
      <h1 class="wizard-title" id="w-title">Elegí un <em>botón.</em></h1>
      <p class="w-note" id="w-note" hidden></p>

      <div class="w-screen" id="w-screen"></div>
    </main>

  </div>

  <script>
  (function(){

    // ── Catálogos ──────────────────────────────────────────────
    const TY = {
      dir:  { pl:"Direcciones", n:"Ir a una dirección",   one:"dirección", i:"map-pin" },
      call: { pl:"Llamadas",    n:"Llamar a un contacto", one:"llamada",   i:"phone"   },
      msg:  { pl:"Mensajes",    n:"Enviar un mensaje",    one:"mensaje",   i:"message" }
    };
    const SUG = {
      dir: ["Casa", "Trabajo", "Colegio"],
      msg: ["Estoy bien", "Llegué", "Ayuda"]
    };
    // Mock de agenda. Reemplazar con fetch al backend cuando se integre.
    const CT = [
      { n:"Mamá",            t:"11 5555 0101" },
      { n:"Papá",            t:"11 5555 0102" },
      { n:"Abuela Rosa",     t:"11 5555 0103" },
      { n:"Tía Laura",       t:"11 5555 0104" },
      { n:"Marcos (hermano)",t:"11 5555 0105" },
      { n:"Lucía (amiga)",   t:"11 5555 0106" },
      { n:"Doctor Pérez",    t:"11 5555 0107" },
      { n:"Martín",          t:"11 5555 0108" }
    ];
    // Estado inicial. Reemplazar con datos reales desde el backend si están disponibles.
    const L = [
      { type:"dir",  items:[
        { n:"Casa",    f:"Av. Rivadavia 4500" },
        { n:"Trabajo", f:"Calle Florida 800" },
        { n:"Colegio", f:"Calle Medrano 120" },
        { n:"Abuela",  f:"Av. Directorio 300" }
      ]},
      { type:"call", items:[
        { n:"Mamá", c:"Mamá", tel:"11 5555 0101" },
        { n:"Papá", c:"Papá", tel:"11 5555 0102" }
      ]},
      { type:"msg",  items:[
        { n:"Estoy bien",      c:"Mamá", tel:"11 5555 0101", txt:"Estoy bien, llego en un rato" },
        { n:"Pasame a buscar", c:"Papá", tel:"11 5555 0102", txt:"Pasame a buscar, por favor" }
      ]}
    ];
    const MAX = 5;

    // ── Helpers ────────────────────────────────────────────────
    const $ = s => document.querySelector(s);
    const cnt = n => n === 1 ? "1 opción" : n + " opciones";
    const norm = s => s.normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase();
    const det = x => x.tel ? (x.txt ? "Para " + x.c + ", " + x.tel + ". " + x.txt : x.c + ", " + x.tel) : x.f;
    const esc = s => (s+'').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));

    // ── Estado ─────────────────────────────────────────────────
    let scr = "menu", cb = 0, ft = "dir", msg = "", selC = null, rt;

    const screen = $("#w-screen");
    const ctx    = $("#w-ctx");
    const title  = $("#w-title");
    const note   = $("#w-note");

    function announce(t){
      const l = $("#live");
      l.textContent = "";
      setTimeout(() => l.textContent = t, 60);
    }

    function setTitle(ctxText, titleHtml, noteText){
      ctx.textContent = ctxText;
      title.innerHTML = titleHtml;
      if (noteText) { note.textContent = noteText; note.hidden = false; }
      else { note.hidden = true; }
    }

    // ── Render ─────────────────────────────────────────────────
    function draw(focusSel, say){
      const o = L[cb], n = o.items.length;
      let h = "", t = "", c = "";
      selC = null;

      if (scr === "menu") {
        c = "Menú principal";
        t = "Elegí un <em>botón.</em>";
        h = "<ul style='list-style:none;margin:0;padding:0'>";
        L.forEach((x, b) => {
          const tipo = x.type ? TY[x.type] : null;
          const subtitle = tipo
            ? '<small>' + tipo.pl + '</small>'
            : '<small>Sin configurar</small>';
          const aria = "Botón " + (b+1) + ", " + (tipo ? tipo.pl : "vacío") + ", " + cnt(x.items.length);
          h += '<li><button type="button" class="w-opt" data-a="open" data-b="' + b + '" aria-label="' + aria + '">' +
                 '<span class="ico"><i class="ti ti-circle-number-' + (b+1) + '"></i></span>' +
                 '<span class="lbl">Botón ' + (b+1) + subtitle + '</span>' +
                 '<span class="n" aria-hidden="true">' + x.items.length + '</span>' +
               '</button></li>';
        });
        h += '</ul>';
        h += '<button type="button" class="w-opt danger" data-a="lost" aria-label="Extravío, hacer sonar el dispositivo">' +
               '<span class="ico"><i class="ti ti-volume"></i></span>' +
               '<span class="lbl">Extravío<small>Hacer sonar el dispositivo</small></span>' +
             '</button>';
        setTitle(c, t, msg || "");
      }

      else if (scr === "list") {
        c = "Botón " + (cb+1) + (o.type ? " · " + TY[o.type].pl : "");
        t = o.type ? "Opciones de <em>" + TY[o.type].pl.toLowerCase() + ".</em>" : "Elegí qué <em>hará este botón.</em>";
        const full = n >= MAX;
        if (n) {
          h = "<ul style='list-style:none;margin:0 0 16px;padding:0'>";
          o.items.forEach((x, j) => {
            h += '<li class="w-item">' +
                   '<span class="nm">' +
                     '<span class="ord">' + (j+1) + ' de ' + n + '</span>' +
                     esc(x.n) +
                     '<small>' + esc(det(x)) + '</small>' +
                   '</span>' +
                   '<button type="button" class="ctrl" data-a="up"  data-j="' + j + '" aria-label="Subir ' + esc(x.n) + '" ' + (j===0?'aria-disabled="true"':'') + '><i class="ti ti-chevron-up"></i></button>' +
                   '<button type="button" class="ctrl" data-a="dn"  data-j="' + j + '" aria-label="Bajar ' + esc(x.n) + '" ' + (j===n-1?'aria-disabled="true"':'') + '><i class="ti ti-chevron-down"></i></button>' +
                   '<button type="button" class="ctrl del" data-a="del" data-j="' + j + '" aria-label="Eliminar ' + esc(x.n) + '"><i class="ti ti-x"></i></button>' +
                 '</li>';
          });
          h += "</ul>";
        }
        h += '<button type="button" class="opt-btn lg block" data-a="add" ' + (full?'aria-disabled="true"':'') + '>' +
               '<i class="ti ti-plus"></i> Agregar' + (full ? ' (máximo ' + MAX + ')' : '') +
             '</button>';
        if (n) {
          h += '<button type="button" class="opt-btn secondary lg block" data-a="chg" style="margin-top:12px;">' +
                 '<i class="ti ti-refresh"></i> Cambiar tipo' +
               '</button>';
        }
        setTitle(c, t);
      }

      else if (scr === "type") {
        c = "Botón " + (cb+1);
        t = "¿Qué <em>tipo</em> va a tener?";
        const used = {};
        L.forEach((x, b) => { if (b !== cb && x.type) used[x.type] = b; });
        const avail = Object.keys(TY).filter(k => !(k in used)).map(k => TY[k].pl);
        const notaDisp = "Disponibles: " + (avail.length ? avail.join(", ") : "ninguno");
        h = "<ul style='list-style:none;margin:0;padding:0'>";
        Object.entries(TY).forEach(([k, v]) => {
          if (k in used) {
            h += '<li><button type="button" class="w-opt" data-a="busy" data-k="' + k + '" aria-disabled="true" aria-label="' + v.n + ', no disponible, ya lo usa el Botón ' + (used[k]+1) + '">' +
                   '<span class="ico"><i class="ti ti-' + v.i + '"></i></span>' +
                   '<span class="lbl">' + v.n + '<small>Ya lo usa el Botón ' + (used[k]+1) + '</small></span>' +
                 '</button></li>';
          } else {
            h += '<li><button type="button" class="w-opt" data-a="type" data-k="' + k + '">' +
                   '<span class="ico"><i class="ti ti-' + v.i + '"></i></span>' +
                   '<span class="lbl">' + v.n + '</span>' +
                 '</button></li>';
          }
        });
        h += '</ul><div class="w-err" id="bz" role="alert"></div>';
        setTitle(c, t, notaDisp);
      }

      else if (scr === "form") {
        c = "Botón " + (cb+1) + " · " + TY[ft].pl;
        t = (ft === "msg" ? "Nuevo <em>mensaje.</em>" : "Nueva <em>" + TY[ft].one + ".</em>");
        if (ft === "dir") {
          h = '<label for="f1">Calle y número</label>' +
              '<input type="text" id="f1" aria-describedby="er" autocomplete="off" />';
        } else {
          h = '<label for="f1">Contacto</label>' +
              '<input type="text" id="f1" role="combobox" aria-autocomplete="list" aria-expanded="false" aria-controls="res" aria-describedby="er" autocomplete="off" placeholder="Escribí un nombre" />' +
              '<div id="res" class="w-ac" aria-label="Contactos encontrados"></div>' +
              '<p class="w-note" id="cinfo"></p>';
        }
        if (ft === "msg") {
          h += '<label for="f3" style="margin-top:14px;">Mensaje</label>' +
               '<input type="text" id="f3" aria-describedby="er" autocomplete="off" />';
        }
        h += '<label for="f2" style="margin-top:14px;">Apodo (una o dos palabras)</label>' +
             '<input type="text" id="f2" maxlength="20" autocomplete="off" aria-describedby="er" />';
        if (SUG[ft]) {
          h += '<div class="w-chips" role="group" aria-label="Sugerencias">' +
               SUG[ft].map(s => '<button type="button" class="w-chip" data-a="chip" data-s="' + esc(s) + '" aria-label="Usar ' + esc(s) + '">' + esc(s) + '</button>').join('') +
               '</div>';
        }
        h += '<div class="w-say"><span class="lbl">La botonera dirá</span><span class="val" id="pvb">"nada"</span></div>' +
             '<div class="w-err" id="er" role="alert"></div>' +
             '<button type="button" class="opt-btn lg block" data-a="save" style="margin-top:18px;">' +
               '<i class="ti ti-device-floppy"></i> Guardar' +
             '</button>';
        setTitle(c, t);
      }

      else if (scr === "more") {
        c = "Botón " + (cb+1);
        t = "Guardado <em>correctamente.</em>";
        h = '<div class="w-ok"><i class="ti ti-check"></i> Botón ' + (cb+1) + ': ' + cnt(n) + '.</div>' +
            '<button type="button" class="opt-btn lg block" data-a="add"><i class="ti ti-plus"></i> Agregar otra</button>' +
            '<button type="button" class="opt-btn secondary lg block" data-a="menu" style="margin-top:12px;"><i class="ti ti-arrow-left"></i> Volver al menú</button>';
        setTitle(c, t);
      }

      else if (scr === "conf") {
        c = "Botón " + (cb+1);
        t = "¿Cambiar el <em>tipo</em> de este botón?";
        h = '<p class="w-note">Al cambiar el tipo se borran sus ' + cnt(n) + '.</p>' +
            '<button type="button" class="opt-btn lg block confirm" data-a="dochg"><i class="ti ti-check"></i> Sí, borrar y cambiar</button>' +
            '<button type="button" class="opt-btn deny lg block" data-a="list" style="margin-top:12px;"><i class="ti ti-x"></i> No, conservar</button>';
        setTitle(c, t);
      }

      screen.innerHTML = h;
      document.title = (c ? c + " · " : "") + "SensePad";
      msg = "";
      if (focusSel !== null) {
        const el = focusSel ? $(focusSel) : title;
        if (el) { el.setAttribute("tabindex","-1"); el.focus(); }
      }
      announce(say ? say + ". " + t.replace(/<[^>]+>/g,"") : t.replace(/<[^>]+>/g,""));
    }

    // ── Autocomplete de contactos ──────────────────────────────
    function results(q){
      const r = $("#res"), i = $("#f1");
      const nq = norm(q.trim());
      const m = nq ? CT.map((c,k)=>[c,k]).filter(([c])=>norm(c.n).includes(nq)).slice(0,4) : [];
      if (!nq) { r.innerHTML = ""; i.setAttribute("aria-expanded","false"); return; }
      r.innerHTML = m.length
        ? m.map(([c,k]) => '<button type="button" class="row" data-a="pick" data-i="' + k + '" aria-label="' + esc(c.n) + ', ' + c.t + '">' +
            '<span class="avi">' + esc(c.n.charAt(0)) + '</span>' +
            '<span class="info"><b>' + esc(c.n) + '</b><small>' + c.t + '</small></span>' +
          '</button>').join('')
        : '<div class="empty">Sin resultados</div>';
      i.setAttribute("aria-expanded", m.length ? "true" : "false");
      clearTimeout(rt);
      rt = setTimeout(() => announce(m.length ? (m.length === 1 ? "1 contacto" : m.length + " contactos") : "Sin resultados"), 500);
    }

    // ── Delegación de eventos ──────────────────────────────────
    document.addEventListener("click", e => {
      const t = e.target.closest("[data-a]");
      if (!t) return;
      const a = t.dataset.a, j = +t.dataset.j, o = L[cb], l = o.items;
      let say = "", focusSel;

      // Casos de "no disponible"
      if (a === "busy") {
        const k = t.dataset.k;
        const u = L.findIndex((x,b) => b !== cb && x.type === k);
        const avail = Object.keys(TY).filter(q => !L.some((x,b) => b !== cb && x.type === q)).map(q => TY[q].pl);
        const txt = "El Botón " + (cb+1) + " no puede ser de " + TY[k].pl.toLowerCase() + ": el Botón " + (u+1) + " ya cumple esa función. Disponibles: " + (avail.join(", ") || "ninguno") + ".";
        const z = $("#bz"); z.textContent = ""; setTimeout(() => z.textContent = txt, 60);
        return;
      }
      if (t.getAttribute("aria-disabled") === "true") {
        announce(a === "add" ? ("Máximo " + MAX + " opciones por botón.") : "No se puede mover más.");
        return;
      }

      // Navegación
      if (a === "menu")  scr = "menu";
      else if (a === "open") { cb = +t.dataset.b; scr = "list"; }
      else if (a === "list") scr = "list";
      else if (a === "lost") { msg = "Haciendo sonar el dispositivo…"; say = msg; }

      // Reorder y delete
      else if (a === "up" || a === "dn") {
        const k = a === "up" ? j - 1 : j + 1;
        [l[j], l[k]] = [l[k], l[j]];
        draw(null);
        const el = document.querySelector('[data-a="' + a + '"][data-j="' + k + '"]');
        if (el) el.focus();
        announce(l[k].n + ", ahora en posición " + (k+1) + " de " + l.length);
        return;
      }
      else if (a === "del") {
        const nm = l[j].n;
        l.splice(j, 1);
        if (!l.length) o.type = null;
        say = nm + " eliminada. " + cnt(l.length) + ".";
      }

      // Flujo de forms
      else if (a === "add") { if (o.type) { ft = o.type; scr = "form"; } else scr = "type"; }
      else if (a === "chg") scr = "conf";
      else if (a === "dochg") { o.items = []; o.type = null; scr = "type"; }
      else if (a === "type")  { ft = t.dataset.k; scr = "form"; }

      // Autocomplete
      else if (a === "pick") {
        selC = CT[+t.dataset.i];
        $("#f1").value = selC.n;
        $("#res").innerHTML = "";
        $("#f1").setAttribute("aria-expanded","false");
        $("#cinfo").textContent = selC.t;
        const f2 = $("#f2");
        if (ft === "call" && !f2.value) { f2.value = selC.n.split(" ")[0]; $("#pvb").textContent = '"' + f2.value + '"'; }
        announce("Elegiste a " + selC.n + ", " + selC.t);
        (ft === "msg" ? $("#f3") : f2).focus();
        return;
      }
      else if (a === "chip") {
        $("#f2").value = t.dataset.s;
        $("#pvb").textContent = '"' + t.dataset.s + '"';
        if (ft === "msg" && !$("#f3").value) $("#f3").value = t.dataset.s;
        announce("Apodo: " + t.dataset.s);
        return;
      }

      // Guardar
      else if (a === "save") {
        const f1 = $("#f1"), f2 = $("#f2"), f3 = $("#f3");
        [f1, f2, f3].forEach(x => x && x.removeAttribute("aria-invalid"));
        let bad = null;
        if (ft === "dir") { if (!f1.value.trim()) bad = [f1, "Falta la dirección."]; }
        else if (!selC || norm(selC.n) !== norm(f1.value)) bad = [f1, "Elegí un contacto de la lista."];
        if (!bad && ft === "msg" && !f3.value.trim()) bad = [f3, "Falta el mensaje."];
        if (!bad && !f2.value.trim()) bad = [f2, "Falta el apodo."];
        if (bad) {
          bad[0].setAttribute("aria-invalid","true");
          $("#er").textContent = bad[1];
          bad[0].focus();
          return;
        }
        const it = { n: f2.value.trim() };
        if (ft === "dir") it.f = f1.value.trim();
        else {
          it.c = selC.n; it.tel = selC.t;
          if (ft === "msg") it.txt = f3.value.trim();
        }
        o.type = ft;
        l.push(it);
        say = "Se guardó " + it.n + ".";
        scr = "more";
      }

      draw(focusSel, say);
    });

    document.addEventListener("input", e => {
      const id = e.target.id;
      if (id === "f2") $("#pvb").textContent = '"' + (e.target.value || "nada") + '"';
      if (id === "f1" && ft !== "dir") {
        selC = null;
        $("#cinfo").textContent = "";
        results(e.target.value);
      }
    });

    // ── Inicio ─────────────────────────────────────────────────
    draw(null);

  })();
  </script>

</body>
</html>