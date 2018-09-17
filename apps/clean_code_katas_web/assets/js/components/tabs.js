const TABS_SELECTOR = '.tabs > ul li'
const ACTIVE_TAB_MENU_SELECTOR = '.tabs .is-active'
const TAB_CONTENT_WRAPPER_SELECTOR = '.tabs-content-wrapper'
const ACTIVE_TAB_CONTENT_SELECTOR = `${TAB_CONTENT_WRAPPER_SELECTOR} .tab-content.is-active`
const ACTIVE_CLASS = 'is-active'

function getTabWrapper(selector) {
  return document.querySelector(selector)
}

function getTabs(selector) {
  return document.querySelectorAll(selector)
}

function hasTabs(selector) {
  return !!getTabWrapper(selector)
}

function getTargetTabContentElement(tabElement) {
  const tabContentSelector = tabElement.dataset.tabContent
  if(tabContentSelector) {
    return document.querySelector(tabContentSelector)
  } else {
    console.error('no tab content selector for tab menu')
  }
}

function isTargetTabContentOpen(tabElement) {
  const tabContent = getTargetTabContentElement(tabElement)
  return tabContent.classList.contains(ACTIVE_CLASS)
}

function getActiveTabContent(selector) {
  return document.querySelector(selector)
}

function getActiveTabMenu(selector) {
  return document.querySelector(selector)
}

function tabMenuClickHandler(event) {
  event.preventDefault()
  const currentTabMenu = event.currentTarget

  if(isTargetTabContentOpen(currentTabMenu)) {
    return
  }


  const activeTabContent = getActiveTabContent(ACTIVE_TAB_CONTENT_SELECTOR)
  const activeTabMenu = getActiveTabMenu(ACTIVE_TAB_MENU_SELECTOR)
  const currentTabContent = getTargetTabContentElement(currentTabMenu)

  activeTabContent.classList.remove(ACTIVE_CLASS)
  activeTabMenu.classList.remove(ACTIVE_CLASS)

  currentTabContent.classList.add(ACTIVE_CLASS)
  currentTabMenu.classList.add(ACTIVE_CLASS)
}

function addClickEventHandler(elements) {
  elements.forEach((element) => {
    element.onclick = tabMenuClickHandler
  })
}

export default function initTabs() {
  if(!hasTabs(TAB_CONTENT_WRAPPER_SELECTOR)) return

  const tabs = getTabs(TABS_SELECTOR)
  addClickEventHandler(tabs)
}