extends Node

var questions = {
	"Português": [
		{
			"question": "Qual a forma correta do plural de 'cidadão'?",
			"answers": ["Cidadãos", "Cidadões", "Cidadães", "Cidadoes", "Cidadãs"],
			"correct": 0
		},
		{
			"question": "O que significa a expressão 'a torto e a direito'?",
			"answers": ["De forma justa", "De forma aleatória", "De qualquer maneira, sem critério", "Com muita força", "Com cuidado"],
			"correct": 2
		}
	],
	"Direito Tributário": [
		{
			"question": "Qual princípio veda a cobrança de tributo no mesmo exercício financeiro em que foi instituído?",
			"answers": ["Princípio da Legalidade", "Princípio da Isonomia", "Princípio da Anterioridade", "Princípio da Capacidade Contributiva", "Princípio da Irretroatividade"],
			"correct": 2
		},
		{
			"question": "O que é o ICMS?",
			"answers": ["Imposto sobre Carros", "Imposto sobre Circulação de Mercadorias e Serviços", "Imposto sobre Compra de Materiais", "Imposto de Contribuição Municipal", "Imposto sobre Contratos"],
			"correct": 1
		}
	],
	"Direito Constitucional": [
		{
			"question": "Qual dos seguintes NÃO é um Poder da União?",
			"answers": ["Executivo", "Legislativo", "Judiciário", "Moderador", "Nenhuma das anteriores"],
			"correct": 3
		},
		{
			"question": "O que é um 'habeas corpus'?",
			"answers": ["Um imposto federal", "Um recurso para proteger a liberdade de locomoção", "Um tipo de contrato", "Uma lei complementar", "Um direito social"],
			"correct": 1
		}
	]
}

func get_random_question():
	var all_questions = []
	for category in questions.values():
		all_questions.append_array(category)

	if all_questions.is_empty():
		return null

	return all_questions.pick_random()