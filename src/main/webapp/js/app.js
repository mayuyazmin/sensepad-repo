// SensePad · Portal Familiar

document.addEventListener('DOMContentLoaded', () => {

  // ── Mostrar / ocultar contraseña ──
  document.querySelectorAll('[data-toggle-password]').forEach(icon => {
    const input = document.getElementById(icon.getAttribute('data-toggle-password'));
    if (!input) return;
    icon.addEventListener('click', () => {
      const shown = input.type === 'text';
      input.type = shown ? 'password' : 'text';
      icon.classList.toggle('ti-eye', shown);
      icon.classList.toggle('ti-eye-off', !shown);
    });
  });

  // ── Auto-avance en boxes del código de vinculación ──
  const boxes = document.querySelectorAll('.code-box');
  if (boxes.length) {
    const hidden = document.getElementById('codigoCompleto');
    const actualizar = () => {
      if (hidden) hidden.value = Array.from(boxes).map(b => b.value).join('');
    };
    boxes.forEach((box, i) => {
      box.addEventListener('input', () => {
        if (box.value && i < boxes.length - 1) boxes[i + 1].focus();
        actualizar();
      });
      box.addEventListener('keydown', e => {
        if (e.key === 'Backspace' && !box.value && i > 0) boxes[i - 1].focus();
      });
    });
  }
});