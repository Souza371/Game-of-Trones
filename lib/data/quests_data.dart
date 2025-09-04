final List<Map<String, dynamic>> quests = [
  {
    'id': 1,
    'title': 'O Ataque dos Bandidos',
    'description': 'Aldeões estão sendo atacados por bandidos na Estrada da Rosa',
    'choices': [
      {
        'text': 'Atacar os bandidos imediatamente',
        'effects': {'Honra': 2, 'Força': 1},
        'skills': ['Combate'],
        'housePoints': {'Stark': 3, 'Baratheon': 2}
      },
      {
        'text': 'Negociar com os bandidos', 
        'effects': {'Inteligência': 2, 'Estratégia': 1},
        'skills': ['Diplomacia'],
        'housePoints': {'Lannister': 3, 'Tyrell': 2}
      },
      {
        'text': 'Buscar ajuda da guarda real',
        'effects': {'Lealdade': 2, 'Estratégia': 1},
        'skills': ['Liderança'],
        'housePoints': {'Arryn': 3, 'Tully': 2}
      }
    ]
  },
  {
    'id': 2,
    'title': 'A Colheita Perdida',
    'description': 'A colheita da vila foi destruída por uma tempestade',
    'choices': [
      {
        'text': 'Doar comida dos estoques',
        'effects': {'Honra': 3, 'Lealdade': 1},
        'housePoints': {'Stark': 4, 'Tully': 2}
      },
      {
        'text': 'Cobrar impostos mesmo assim',
        'effects': {'Ambição': 3, 'Inteligência': 1},
        'housePoints': {'Lannister': 4, 'Frey': 2}
      },
      {
        'text': 'Organizar uma nova plantação',
        'effects': {'Estratégia': 3, 'Inteligência': 2},
        'housePoints': {'Tyrell': 4, 'Martell': 2}
      }
    ]
  }
];
