// для примера
const initialNotes = [
    { id: crypto.randomUUID(), title: "Сдать отчет",   date: "23 Июля 2024", tag: "Работа" },
    { id: crypto.randomUUID(), title: "Сдать отчет",   date: "23 Июля 2024", tag: "Работа" },
    { id: crypto.randomUUID(), title: "Сдать отчет",   date: "23 Июля 2024", tag: "Работа" }
  ];
  
  let state = {
    notes: [...initialNotes],
    query: "",
    tag: "Все"
  };
  
  const $ = (sel) => document.querySelector(sel);
  const notesList = $("#notesList");
  const searchInput = $("#searchInput");
  const searchBtn = $("#searchBtn");
  const tagList = $("#tagList");
  const createBtn = $("#createNoteBtn");
  
  function renderNotes() {
    const { notes, query, tag } = state;
  
    const filtered = notes.filter(n => {
      const matchesQuery = n.title.toLowerCase().includes(query);
      const matchesTag = tag === "Все" ? true : n.tag === tag;
      return matchesQuery && matchesTag;
    });
  
    notesList.innerHTML = filtered.map(toNoteHTML).join("") || emptyStateHTML();
  }
  
  function toNoteHTML(n){
    return `
      <article class="note-card" data-id="${n.id}">
        <div class="note-head">
          <h3 class="note-title">${escapeHTML(n.title)}</h3>
          <span class="badge">${escapeHTML(n.tag)}</span>
        </div>
        <div class="note-meta">${escapeHTML(n.date)}</div>
      </article>
    `;
  }
  
  function emptyStateHTML(){
    return `
      <article class="note-card">
        <div class="note-head">
          <h3 class="note-title">Ничего не найдено</h3>
        </div>
        <div class="note-meta">Измените запрос или выберите другой тег.</div>
      </article>
    `;
  }
  
  function escapeHTML(str){
    return String(str)
      .replaceAll("&","&amp;")
      .replaceAll("<","&lt;")
      .replaceAll(">","&gt;")
      .replaceAll('"',"&quot;")
      .replaceAll("'","&#39;");
  }
  
  searchInput.addEventListener("input", (e) => {
    state.query = e.target.value.trim().toLowerCase();
    renderNotes();
  });
  searchBtn.addEventListener("click", () => searchInput.focus());
  
  tagList.addEventListener("click", (e) => {
    const btn = e.target.closest(".tag-item");
    if(!btn) return;
    tagList.querySelectorAll(".tag-item").forEach(b => b.classList.remove("tag-item--active"));
    btn.classList.add("tag-item--active");
    state.tag = btn.dataset.tag;
    renderNotes();
  });
  
  createBtn.addEventListener("click", () => {
    const title = prompt("Название заметки:", "Новая заметка");
    if(!title) return;
    const tag = prompt("Тег (Идеи / Личное / Работа / Список покупок):", "Работа") || "Личное";
    const date = formatDateRu(new Date());
    state.notes.unshift({ id: crypto.randomUUID(), title: title.trim(), tag: tag.trim(), date });
    renderNotes();
  });
  
  function formatDateRu(d){
    const months = ["Января","Февраля","Марта","Апреля","Мая","Июня","Июля","Августа","Сентября","Октября","Ноября","Декабря"];
    return `${d.getDate()} ${months[d.getMonth()]} ${d.getFullYear()}`;
  }
  
  renderNotes();
  