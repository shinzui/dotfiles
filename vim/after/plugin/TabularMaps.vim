if !exists(':Tabularize')
  finish " Tabular.vim wasn't loaded
endif

AddTabularPattern!  assignment      / = /l0
AddTabularPattern!  two_spaces      /  /l0
AddTabularPattern!  symbols         / :/l0
AddTabularPattern!  hash            /=>/
