local ft = vim.filetype
ft.add({
  pattern = {
    ['.*/*.cls'] = 'apex',
    ['.*/*.trigger'] = 'apex',
  },
})
