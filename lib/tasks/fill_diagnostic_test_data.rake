namespace :user do
  desc "Fill Diagnostic Test tables with quetion data"
  task :fill_diagnostic_test_data => :environment do
	##Ingreso de datos a categorias
	DiagnosticTestCategory.create nombre: "Lexical access"
	DiagnosticTestCategory.create nombre: "Syntactic process"
	DiagnosticTestCategory.create nombre: "Syntactic process, Lexical access"
	DiagnosticTestCategory.create nombre: "Listening comprehension"
	DiagnosticTestCategory.create nombre: "Understand vocabulary, Negotiating meaning"

	##Ingreso de datos a niveles
	DiagnosticTestLevel.create sigla: "AB", nombre: "Novice Low-Mid"
	DiagnosticTestLevel.create sigla: "C", nombre: "Novice High"
	DiagnosticTestLevel.create sigla: "D", nombre: "Intermediate Low"
	DiagnosticTestLevel.create sigla: "E", nombre: "Intermediate Mid"

	##Ingreso de datos a preguntas
	#Nivel AB
	DiagnosticTestQuestion.create enunciado: "Identify the following color: \n 1_1.jpg", category_id: 1, level_id: 1, answer_id: 1, numero: 1
	DiagnosticTestQuestion.create enunciado: "Identify the following color: \n 1_2.jpg", category_id: 1, level_id: 1, answer_id: 2, numero: 2
	DiagnosticTestQuestion.create enunciado: "Identify the following color: \n 1_3.jpg", category_id: 1, level_id: 1, answer_id: 3, numero: 3
	DiagnosticTestQuestion.create enunciado: "Identify the following color: \n 1_4.jpg", category_id: 1, level_id: 1, answer_id: 4, numero: 4
	DiagnosticTestQuestion.create enunciado: "Look at the following picture and identify what it is: \n 1_5.jpg", category_id: 1, level_id: 1, answer_id: 5, numero: 5
	DiagnosticTestQuestion.create enunciado: "Look at the following picture and identify what it is: \n 1_6.jpg", category_id: 1, level_id: 1, answer_id: 6, numero: 6
	DiagnosticTestQuestion.create enunciado: "Look at the following picture and identify what it is: \n 1_7.jpg", category_id: 1, level_id: 1, answer_id: 7, numero: 7
	DiagnosticTestQuestion.create enunciado: "Look at the following picture and identify what it is: \n 1_8.jpg", category_id: 1, level_id: 1, answer_id: 8, numero: 8
	DiagnosticTestQuestion.create enunciado: "Look at the following picture and identify what it is: \n 1_9.jpg", category_id: 1, level_id: 1,  answer_id: 9, numero: 9
	DiagnosticTestQuestion.create enunciado: "Choose the correct word to complete the sentence. \n She __________ Spanish.", category_id: 3, level_id: 1,  answer_id: 10, numero: 10
	DiagnosticTestQuestion.create enunciado: "Choose the correct word to complete the sentence. \n I ________ happy.", category_id: 3, level_id: 1,  answer_id: 11, numero: 11
	DiagnosticTestQuestion.create enunciado: "Choose the correct word to complete the sentence. \n You _________ so tall.", category_id: 2, level_id: 1,  answer_id: 12, numero: 12
	DiagnosticTestQuestion.create enunciado: "Choose the correct word to complete the sentence. \n He __________ very smart.", category_id: 2, level_id: 1,  answer_id: 13, numero: 13
	DiagnosticTestQuestion.create enunciado: "Choose the correct word to complete the sentence. \n She __________ 19 years old.", category_id: 2, level_id: 1,  answer_id: 14, numero: 14
	DiagnosticTestQuestion.create enunciado: "Choose the correct word to complete the sentence. \n This tree __________ very tall ", category_id: 2, level_id: 1,  answer_id: 15, numero: 15
	DiagnosticTestQuestion.create enunciado: "Choose the correct word to complete the sentence. \n He _________ his homework.", category_id: 2, level_id: 1,  answer_id: 16, numero: 16
	DiagnosticTestQuestion.create enunciado: "Choose the correct word to complete the sentence. \n John wants to __________ a new car.", category_id: 3, level_id: 1,  answer_id: 17, numero: 17
	DiagnosticTestQuestion.create enunciado: "Choose the correct word to complete the sentence. \n My house ________ very old.", category_id: 2, level_id: 1,  answer_id: 18, numero: 18
	DiagnosticTestQuestion.create enunciado: "Choose the correct word to complete the sentence. \n We _____________ to cancel the trip.", category_id: 2, level_id: 1,  answer_id: 19, numero: 19
	DiagnosticTestQuestion.create enunciado: "Identify the wrong sentence", category_id: 3, level_id: 1,  answer_id: 20, numero: 20
	DiagnosticTestQuestion.create enunciado: "Identify the wrong sentence", category_id: 3, level_id: 1,  answer_id: 21, numero: 21
	DiagnosticTestQuestion.create enunciado: "Identify the wrong sentence", category_id: 3, level_id: 1,  answer_id: 22, numero: 22
	DiagnosticTestQuestion.create enunciado: "Identify the wrong sentence", category_id: 3, level_id: 1,  answer_id: 23, numero: 23
	DiagnosticTestQuestion.create enunciado: "Identify the correct alternative  \n Someone gaves the school mice every year.", category_id: 3, level_id: 1,  answer_id: 24, numero: 24
	DiagnosticTestQuestion.create enunciado: "Identify the correct alternative  \n Valerie claims that cats is the best pets.", category_id: 3, level_id: 1,  answer_id: 25, numero: 25
	DiagnosticTestQuestion.create enunciado: "Identify the correct alternative  \n Dogs ____________ their tails if they are friendly.", category_id: 3, level_id: 1,  answer_id: 26, numero: 26
	DiagnosticTestQuestion.create enunciado: "Identify the correct alternative  \n The Lusitania ________ on May 7, 1915.", category_id: 3, level_id: 1,  answer_id: 27, numero: 27
	DiagnosticTestQuestion.create enunciado: "Choose the missing word. \n Is that Jenny’s writing? ‘No, _________________ is smaller.’", category_id: 3, level_id: 1,  answer_id: 28, numero: 28
	DiagnosticTestQuestion.create enunciado: "Choose the missing word. \n Let’s compare ________________ apartments.", category_id: 3, level_id: 1,  answer_id: 29, numero: 29
	DiagnosticTestQuestion.create enunciado: "Choose the missing word. \n ‘Is that your couch?’ ‘No it isn’t _________________’ .", category_id: 3, level_id: 1,  answer_id: 30, numero: 30
	DiagnosticTestQuestion.create enunciado: "Do you call _____________ friends a lot?", category_id: 3, level_id: 1,  answer_id: 31, numero: 31
	DiagnosticTestQuestion.create enunciado: "Choose the missing word. \n You can know more about your friends by studying ______________ handwriting.", category_id: 3, level_id: 1,  answer_id: 32, numero: 32
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n The elevation of West Virginia is 1,500 foot above sea DiagnosticTestLevel.", category_id: 2, level_id: 1,  answer_id: 33, numero: 33
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n Her cat is very friendly, and he goes everywhere she go.", category_id: 3, level_id: 1,  answer_id: 34, numero: 34
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n The students write on de board.", category_id: 3, level_id: 1,  answer_id: 35, numero: 35
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n A gene are a biological unit of information.", category_id: 2, level_id: 1,  answer_id: 36, numero: 36
	DiagnosticTestQuestion.create enunciado: "Change the mistake in the sentence.  \n She like eating chocolate.", category_id: 2, level_id: 1,  answer_id: 37, numero: 37
	DiagnosticTestQuestion.create enunciado: "Change the mistake in the sentence.  \n Yesterday, my mother and I go shopping.", category_id: 3, level_id: 1,  answer_id: 38, numero: 38
	DiagnosticTestQuestion.create enunciado: "Change the mistake in the sentence.  \n She work on a report.", category_id: 3, level_id: 1,  answer_id: 39, numero: 39
	DiagnosticTestQuestion.create enunciado: "Change the mistake in the sentence.  \n People smile when they is happy.", category_id: 3, level_id: 1,  answer_id: 40, numero: 40
	DiagnosticTestQuestion.create enunciado: "Change the mistake in the sentence.  \n I have thirty six years old.", category_id: 2, level_id: 1,  answer_id: 41, numero: 41
	DiagnosticTestQuestion.create enunciado: "Change the mistake in the sentence.  \n I am agree with you.", category_id: 2, level_id: 1,  answer_id: 42, numero: 42
	DiagnosticTestQuestion.create enunciado: "Change the mistake in the sentence.  \n She do not know how to ride a bike. ", category_id: 2, level_id: 1,  answer_id: 43, numero: 43
	DiagnosticTestQuestion.create enunciado: "Change the mistake in the sentence.  \n People is happy.", category_id: 2, level_id: 1,  answer_id: 44, numero: 44
	DiagnosticTestQuestion.create enunciado: "Change the mistake in the sentence.  \n I have hungry.", category_id: 2, level_id: 1,  answer_id: 45, numero: 45
	DiagnosticTestQuestion.create enunciado: "Change the mistake in the sentence.  \n I do a lot of mistakes.", category_id: 3, level_id: 1,  answer_id: 46, numero: 46
	DiagnosticTestQuestion.create enunciado: "Choose the correct missing word \n ‘Is that Tomas’ calculator?’ ‘I don’t know. It could be ________________’", category_id: 2, level_id: 1,  answer_id: 47, numero: 47
	DiagnosticTestQuestion.create enunciado: "Choose the correct missing word \n  ____________ daughters are beautiful.", category_id: 2, level_id: 1,  answer_id: 48, numero: 48
	DiagnosticTestQuestion.create enunciado: "Choose the correct missing word \n  ______________ teachers complain about bad writing. ", category_id: 2, level_id: 1,  answer_id: 49, numero: 49
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n I hate______________ pasta and pizzas. ", category_id: 2, level_id: 1,  answer_id: 50, numero: 50
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n _____________ apple a day keeps the doctor away. ", category_id: 2, level_id: 1,  answer_id: 51, numero: 51
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n _____________ money doesn't make you happy. ", category_id: 2, level_id: 1,  answer_id: 52, numero: 52
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n It is difficult to see _________ bear.", category_id: 2, level_id: 1,  answer_id: 53, numero: 53
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n When we were __________ children,", category_id: 2, level_id: 1,  answer_id: 54, numero: 54
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n We really like ____________ instruments.", category_id: 2, level_id: 1,  answer_id: 55, numero: 55
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n Bambi is a ___________ ", category_id: 1, level_id: 1,  answer_id: 56, numero: 56
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n The sky is blue and roses are __________.", category_id: 1, level_id: 1,  answer_id: 57, numero: 57
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n Is this __________ jacket?", category_id: 1, level_id: 1,  answer_id: 58, numero: 58
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n I have ___________ good news for you.", category_id: 2, level_id: 1,  answer_id: 59, numero: 59
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n I really like ___________ jeans over there", category_id: 2, level_id: 1,  answer_id: 60, numero: 60
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n Eating too ____________ junk food is bad for your health.", category_id: 2, level_id: 1,  answer_id: 61, numero: 61
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n _____________ strawberries are delicious.", category_id: 2, level_id: 1,  answer_id: 62, numero: 62
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n ____________ women are very sensitive and emotional.", category_id: 2, level_id: 1, answer_id: 63, numero: 63
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n You eat too __________ fast food.", category_id: 2, level_id: 1,  answer_id: 64, numero: 64
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n I really ___________ the personality of Brutus. ", category_id: 1, level_id: 1,  answer_id: 65, numero: 65
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n The setting of a story ______________.", category_id: 3, level_id: 1,  answer_id: 66, numero: 66
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n Can you check if there is ___________ sugar left?", category_id: 2, level_id: 1,  answer_id: 67, numero: 67
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n My hats is on the table. It’s the pink one with green spots.", category_id: 2, level_id: 1,  answer_id: 68, numero: 68
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n It's not you fault.", category_id: 3, level_id: 1,  answer_id: 69, numero: 69
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n I do mine homework.", category_id: 3, level_id: 1,  answer_id: 70, numero: 70
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n I work every days", category_id: 2, level_id: 1,  answer_id: 71, numero: 71
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n That girl is much tall.", category_id: 2, level_id: 1,  answer_id: 72, numero: 72
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n This is Lucy. This is his husband.", category_id: 3, level_id: 1,  answer_id: 73, numero: 73
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word which is not correct \n I am an doctor.", category_id: 2, level_id: 1,  answer_id: 74, numero: 74
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete each sentence \n I live _______ the second floor (in/on).", category_id: 2, level_id: 1,  answer_id: 75, numero: 75
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete each sentence \n She was sitting _________ the table, having lunch (at/in).", category_id: 2, level_id: 1,  answer_id: 76, numero: 76
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete each sentence \n I'll call you _________ your mobile (to/on).", category_id: 2, level_id: 1,  answer_id: 77, numero: 77
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n Where did Carol, Jack and Thomas find the painting?", category_id: 4, level_id: 1,  answer_id: 78, numero: 78
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n The painting was about: ", category_id: 4, level_id: 1,  answer_id: 79, numero: 79
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n Apparently the person who made the painting was named:", category_id: 4, level_id: 1,  answer_id: 80, numero: 80
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n “Jack called them from the basement” \n basement", category_id: 5, level_id: 1,  answer_id: 81, numero: 81
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n “Autumn Landscape with Boats” \n autumn", category_id: 5, level_id: 1,  answer_id: 82, numero: 82
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n “It was not big but it looked vibrant and colorful” \n vibrant", category_id: 5, level_id: 1,  answer_id: 83, numero: 83
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n What are the children’s names?", category_id: 4, level_id: 1,  answer_id: 84, numero: 84
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n When do they go for a picnic?", category_id: 4, level_id: 1,  answer_id: 85, numero: 85
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n This time, they feel blue and...", category_id: 4, level_id: 1,  answer_id: 86, numero: 86
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'They feel blue and hungry, but they don’t cry.' \n blue", category_id: 5, level_id: 1,  answer_id: 87, numero: 87
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n “They take sandwiches, cakes, bananas and soda” \n soda", category_id: 5, level_id: 1,  answer_id: 88, numero: 88
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'This time, a cow eats their picnic' \n This time", category_id: 5, level_id: 1,  answer_id: 89, numero: 89
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n Where is Kadinsky from?", category_id: 4, level_id: 1,  answer_id: 90, numero: 90
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n How does the writer describe this painting?", category_id: 4, level_id: 1,  answer_id: 91, numero: 91
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'The excitement of contrasting geometric shapes are the focus of Black and Violet painted by Russian artist Wassily Kandinsky' \n excitement", category_id: 5, level_id: 1,  answer_id: 92, numero: 92
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'The geometric shapes in this composition are uniquely used to create an appearance of infinite shapes that continue pattern deeper and deeper into themselves' \n uniquely", category_id: 5, level_id: 1,  answer_id: 93, numero: 93
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'The geometric shapes in this composition are uniquely used to create an appearance of infinite shapes that continue pattern deeper and deeper into themselves' \n pattern", category_id: 5, level_id: 1,  answer_id: 94, numero: 94
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n What is Sarah celebrating today?", category_id: 4, level_id: 1,  answer_id: 95, numero: 95
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n The living room was full of: ", category_id: 4, level_id: 1,  answer_id: 96, numero: 96
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n Sarah is excited because:", category_id: 4, level_id: 1,  answer_id: 97, numero: 97
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'Sarah is very excited, her friends are arriving and she can see they bring her a lot of birthday presents' \n excited", category_id: 5, level_id: 1,  answer_id: 98, numero: 98
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'The living room is full with red, yellow and green balloons, and gold and blue confetti everywhere' \n confetti", category_id: 5, level_id: 1,  answer_id: 99, numero: 99
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'The table is full with coconut and strawberry cupcakes' \n strawberry", category_id: 5, level_id: 1,  answer_id: 100, numero: 100
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n What was grandpa George doing when he found the map?", category_id: 4, level_id: 1,  answer_id: 101, numero: 101
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n Who made the old map?", category_id: 4, level_id: 1,  answer_id: 102, numero: 102
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n What is the most valuable treasure of grandpa George?", category_id: 4, level_id: 1,  answer_id: 103, numero: 103
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'his favourite pirate book and inside of it his most valuable treasure' \n valuable", category_id: 5, level_id: 1,  answer_id: 104, numero: 104
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'He suddenly found an old map under his favourite oak tree' \n oak", category_id: 5, level_id: 1,  answer_id: 105, numero: 105
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the word in the following sentences. \n 'An old silver coin that his grandfather wore as a necklace and a picture of him' \n silver", category_id: 5, level_id: 1,  answer_id: 106, numero: 106

	#Nivel C
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n Do you eat _______ ?", category_id: 1, level_id: 2, answer_id: 107, numero: 1
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n - Jason always insults me.
	            - Don't worry.  He __________ too.", category_id: 2, level_id: 2, answer_id: 108, numero: 2
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n  - What's wrong with Darren?
	            - He _________ stomachache.", category_id: 3, level_id: 2, answer_id: 109, numero: 3
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n _________ you like action movies?", category_id: 2, level_id: 2, answer_id: 110, numero: 4
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n    - Why is Bob so upset?
	            - He saw a bad accident that ____________ this morning.", category_id: 2, level_id: 2, answer_id: 111, numero: 5
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n Susana is now ____________ home. ", category_id: 2, level_id: 2, answer_id: 112, numero: 6
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n - Jane is 6'4\".
	    - She is the __________ four sisters.", category_id: 3, level_id: 2, answer_id: 113, numero: 7
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n The child was ____________ on his chewing gum.", category_id: 1, level_id: 2, answer_id: 114, numero: 8
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n The ____________ of geese were flying south for the winter. ", category_id: 1, level_id: 2, answer_id: 115, numero: 9
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n The __________ were placed beside the horse's eyes.", category_id: 1, level_id: 2, answer_id: 116, numero: 10
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n The cruel man was ___________ his dog with a wooden stick", category_id: 2, level_id: 2, answer_id: 117, numero: 11
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n Elderly people are often ____________ to broken bones.", category_id: 1, level_id: 2, answer_id: 118, numero: 12
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n I bought these jeans at a ___________ price.", category_id: 1, level_id: 2, answer_id: 119, numero: 13
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n He will spend 20 years in prison for his involvement in _________ activities.", category_id: 1, level_id: 2, answer_id: 120, numero: 14
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n Atacama's desert is ____________ in the world.", category_id: 3, level_id: 2, answer_id: 121, numero: 15
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n Humans, ___________, interact through communicative behavior by means of signs or symbols used conventionally.", category_id: 2, level_id: 2, answer_id: 122, numero: 16
	DiagnosticTestQuestion.create enunciado: "Choose the correct DiagnosticTestAnswer. \n Atacama desert is __________ driest in the world.", category_id: 2, level_id: 2, answer_id: 123, numero: 17
	DiagnosticTestQuestion.create enunciado: "Choose the alternative that corrects the mistake in the sentence.  \n My brother is more older than me.", category_id: 3, level_id: 2, answer_id: 124, numero: 18
	DiagnosticTestQuestion.create enunciado: "Choose the alternative that corrects the mistake in the sentence.  \n There were much people in the restaurant.", category_id: 3, level_id: 2, answer_id: 125, numero: 19
	DiagnosticTestQuestion.create enunciado: "Complete with the comparative or superlative form of the adjectives in parenthesis.  \n My sister is ______________ (young) than me.", category_id: 3, level_id: 2, answer_id: 126, numero: 20
	DiagnosticTestQuestion.create enunciado: "Complete with the comparative or superlative form of the adjectives in parenthesis.  \n Costanera Center is _________________ (tall) building in South America.", category_id: 3, level_id: 2, answer_id: 127, numero: 21
	DiagnosticTestQuestion.create enunciado: "Complete with the comparative or superlative form of the adjectives in parenthesis.  \n Life in the countryside is ___________________ (relaxed) than in the city.", category_id: 3, level_id: 2, answer_id: 128, numero: 22
	DiagnosticTestQuestion.create enunciado: "Complete with the comparative or superlative form of the adjectives in parenthesis.  \n The cheetah is _________________ (fast) of all land animals.", category_id: 3, level_id: 2, answer_id: 129, numero: 23
	DiagnosticTestQuestion.create enunciado: "Complete with the comparative or superlative form of the adjectives in parenthesis.  \n The subway is ____________________ (expensive) than the bus.", category_id: 3, level_id: 2, answer_id: 130, numero: 24
	DiagnosticTestQuestion.create enunciado: "Complete with the comparative or superlative form of the adjectives in parenthesis.  \n My sister reads ____________________ (fast) than me.", category_id: 3, level_id: 2, answer_id: 131, numero: 25
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n  Yesterday, my best friend __________________ an accident. ", category_id: 3, level_id: 2, answer_id: 132, numero: 26
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n  She ________________ me how it happened.", category_id: 3, level_id: 2, answer_id: 133, numero: 27
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n  Because she _______________ distracted by a loud noise", category_id: 3, level_id: 2, answer_id: 134, numero: 28
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n  She ________________ cookies at the time. ", category_id: 3, level_id: 2, answer_id: 135, numero: 29
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n  She ________________ a strange noise. ", category_id: 3, level_id: 2, answer_id: 136, numero: 30
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n  She _________________ inside.", category_id: 3, level_id: 2, answer_id: 137, numero: 31
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n  And right at that moment, she _______________  into something. ", category_id: 3, level_id: 2, answer_id: 138, numero: 32
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n  It was a dog that _________________ in the middle of the sidewalk.", category_id: 3, level_id: 2, answer_id: 139, numero: 33
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n  Then, she ______________  and broke her arm.", category_id: 3, level_id: 2, answer_id: 140, numero: 34
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n  So finally, people _____________ her to the hospital. ", category_id: 3, level_id: 2, answer_id: 141, numero: 35
	DiagnosticTestQuestion.create enunciado: "Complete the following passage with the correct form of the words in past simple or continuous.  \n Nothing serious _____________ .", category_id: 3, level_id: 2, answer_id: 142, numero: 36
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n Where is this meaningful scene from?", category_id: 4, level_id: 2, answer_id: 143, numero: 37
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n Where is the church placed?", category_id: 4, level_id: 2, answer_id: 144, numero: 38
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n All the artwork seems to be _____________. ", category_id: 4, level_id: 2, answer_id: 145, numero: 39
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n What is the title of this painting associated with?", category_id: 4, level_id: 2, answer_id: 146, numero: 40
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n What is created by circles, triangles and linear elements? ", category_id: 4, level_id: 2, answer_id: 147, numero: 41
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives  \n What tendency is found in this painting?", category_id: 4, level_id: 2, answer_id: 148, numero: 42
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “In which the constant repetition of elements reinforces the idea of musical elements being played at the same time.” \n reinforces", category_id: 5, level_id: 2, answer_id: 149, numero: 43
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “The first ones imply movement, whereas the others remain as a sign of stability.” \n remain", category_id: 5, level_id: 2, answer_id: 150, numero: 44
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives. \n What makes Guernica a personal work?", category_id: 4, level_id: 2, answer_id: 151, numero: 45
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives. \n What is the meaning of the word “Guernica”?", category_id: 4, level_id: 2, answer_id: 1592, numero: 46
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives. \n What does Guernica represent?", category_id: 4, level_id: 2, answer_id: 153, numero: 47
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “Guernica” is principally a war painting, offering the viewer a pictorial account of the overwhelming and chaotic impact of war on both men and women, in this case definitely on citizen life and communities.” \n overwhelming", category_id: 5, level_id: 2, answer_id: 154, numero: 48
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “Picasso finished the masterpiece in 1937, a time of widespread political disturbance not just in Spain, but internationally.” \n widespread", category_id: 5, level_id: 2, answer_id: 155, numero: 49
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “A figure sprawled supine in the focal point of the painting seems to be a corpse and it is surrounded, on both sides, by living victims with their heads hanging backwards, waiting in misery and agony” \n waiting", category_id: 5, level_id: 2, answer_id: 156, numero: 50
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between three people and DiagnosticTestAnswer the following DiagnosticTestQuestions. \n Why does Francisco have the account book?", category_id: 4, level_id: 2, answer_id: 157, numero: 51
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between three people and DiagnosticTestAnswer the following DiagnosticTestQuestions. \n Why does Constanza need help?", category_id: 4, level_id: 2, answer_id: 158, numero: 52
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between three people and DiagnosticTestAnswer the following DiagnosticTestQuestions. \n Why is Constanza happy?", category_id: 4, level_id: 2, answer_id: 159, numero: 53
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between three people and DiagnosticTestAnswer the following DiagnosticTestQuestions. \n Could Roberto find Francisco?", category_id: 4, level_id: 2, answer_id: 160, numero: 54
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between three people and DiagnosticTestAnswer the following DiagnosticTestQuestions. \n What does Roberto need to do?", category_id: 4, level_id: 2, answer_id: 161, numero: 55
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between four strangers in an elevator and then DiagnosticTestAnswer the following DiagnosticTestQuestions. \n The conversation occurs during what part of the day?", category_id: 4, level_id: 2, answer_id: 162, numero: 56
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between four strangers in an elevator and then DiagnosticTestAnswer the following DiagnosticTestQuestions. \n What is going to happen weather-wise in the night?", category_id: 4, level_id: 2, answer_id: 163, numero: 57
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between four strangers in an elevator and then DiagnosticTestAnswer the following DiagnosticTestQuestions. \n What happens when they are talking in the elevator?", category_id: 4, level_id: 2, answer_id: 164, numero: 58
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between four strangers in an elevator and then DiagnosticTestAnswer the following DiagnosticTestQuestions. \n Who is the first to get off the elevator?", category_id: 4, level_id: 2, answer_id: 165, numero: 59

	#Nivel D
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n - When are you going on vacation? \n - We are going __________ on Saturday. ", category_id: 2, level_id: 3, answer_id: 166, numero: 1
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n - Why is your company going out of business? \n	- We had ____________ customers.", category_id: 2, level_id: 3, answer_id: 167, numero: 2
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n - What's the purpose of that object? \n - It's a machine ____________ documents.", category_id: 2, level_id: 3, answer_id: 168, numero: 3
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n - This neighborhood is terrible. \n      - Yes, the people ____________ here really don't like it.", category_id: 2, level_id: 3, answer_id: 169, numero: 4
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n Mount Everest, ______________ has been explored many times, is the highest mountain in the world.", category_id: 2, level_id: 3, answer_id: 170, numero: 5
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n The boxer threw a __________ at his opponent. ", category_id: 2, level_id: 3, answer_id: 171, numero: 6
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n - What is your favorite pastime? \n  - I enjoy swimming __________.", category_id: 2, level_id: 3, answer_id: 172, numero: 7
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n - What's your favorite hobby? \n      -  ____________ in reading popular novels.", category_id: 3, level_id: 3, answer_id: 173, numero: 8
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n - Sue has so many useful skills. \n    - I know.  In addition ____________, she also does knitting.", category_id: 3, level_id: 3, answer_id: 174, numero: 9
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n Farming and raising animals are ___________ activities .", category_id: 1, level_id: 3, answer_id: 175, numero: 10
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n A ___________ exists between the United States and the United Kingdom concerning such matters.", category_id: 1, level_id: 3, answer_id: 176, numero: 11
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n Maria was caught in a sudden ____________ without her umbrella. ", category_id: 1, level_id: 3, answer_id: 177, numero: 12
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n I __________ to go to the beach last weekend, but my father got really ill. ", category_id: 2, level_id: 3, answer_id: 178, numero: 13
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n - \"What did the weather report say? \" \n  - \"That it __________ rain tomorrow.\"", category_id: 2, level_id: 3, answer_id: 179, numero: 14
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n I'm used to ______________ the bus in the morning. ", category_id: 2, level_id: 3, answer_id: 180, numero: 15
	DiagnosticTestQuestion.create enunciado: "There are dark clouds in the sky, it ___________ rain. ", category_id: 2, level_id: 3, answer_id: 181, numero: 16
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n If you continue eating chocolate like that, you _____________ get fat.", category_id: 2, level_id: 3, answer_id: 182, numero: 17
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n Our new car should be delivered any day now. I hope you'll take us for a drive as soon as it _______________. ", category_id: 2, level_id: 3, answer_id: 183, numero: 18
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative to complete the sentence. \n The first transatlantic telephone cable system was not established _______ 1956. ", category_id: 3, level_id: 3, answer_id: 184, numero: 19
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n I usually travel home __________ car. (", category_id: 2, level_id: 3, answer_id: 185, numero: 20
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n I will wait ___________ seven. If he doesn't show up, I'll go home. ", category_id: 2, level_id: 3, answer_id: 186, numero: 21
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n My parents have been married ___________ 25 years.", category_id: 2, level_id: 3, answer_id: 187, numero: 22
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n My teacher __________ England is very nice and kind. ", category_id: 2, level_id: 3, answer_id: 188, numero: 23
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n We spent a lot of time ________________.", category_id: 2, level_id: 3, answer_id: 189, numero: 24
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n Oxford Street was ________________ crowded as Christmas is not far off. ", category_id: 3, level_id: 3, answer_id: 190, numero: 25
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n The prices were so ________________ that we didn't mind. ", category_id: 3, level_id: 3, answer_id: 191, numero: 26
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n Actually, the prices were a lot _______________ than usual. ", category_id: 3, level_id: 3, answer_id: 192, numero: 27
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n The shop ______________ were terribly busy. ", category_id: 1, level_id: 3, answer_id: 193, numero: 28
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n Most of them were quite_______________.", category_id: 3, level_id: 3, answer_id: 194, numero: 29
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n One problem was that we didn't understand the English ________________, which were in inches.", category_id: 1, level_id: 3, answer_id: 195, numero: 30
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n  _______________, we had some help.", category_id: 3, level_id: 3, answer_id: 196, numero: 31
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n We asked the ____________ in the department store. ", category_id: 1, level_id: 3, answer_id: 197, numero: 32
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n He kindly gave us a ____________ chart with everything in centimeters. ", category_id: 1, level_id: 3, answer_id: 198, numero: 33
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n All the wonderful ____________ goods we bought are the right size!", category_id: 1, level_id: 3, answer_id: 199, numero: 34
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n Last week, I _____________ my grandparents.", category_id: 2, level_id: 3, answer_id: 200, numero: 35
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n I ______________ attend the meeting last Monday.", category_id: 2, level_id: 3, answer_id: 201, numero: 36
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n My daughter ______________ sick yesterday.", category_id: 3, level_id: 3, answer_id: 202, numero: 37
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n I _______________ bad that day.", category_id: 3, level_id: 3, answer_id: 203, numero: 38
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n Before that day, I ____________ my grandmother.", category_id: 2, level_id: 3, answer_id: 204, numero: 39
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n I ____________ to the doctor that day. ", category_id: 2, level_id: 3, answer_id: 205, numero: 40
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n Everything ______________ too fast. ", category_id: 2, level_id: 3, answer_id: 206, numero: 41
	DiagnosticTestQuestion.create enunciado: "Choose the correct alternative. \n I could tell her that I ____________ to see them. ", category_id: 2, level_id: 3, answer_id: 207, numero: 42
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n The flowering of African American talent in literature, music, and art in the 1920’s in New York City became to know as the Harlem Renaissance.", category_id: 3, level_id: 3, answer_id: 208, numero: 43
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n After flax is washed, dry, beaten, and combed, fibers are obtained for use in making fabric. ", category_id: 3, level_id: 3, answer_id: 209, numero: 44
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n The particles comprising a given cloud are continually changing, as new ones are added while others are taking away by moving air. .", category_id: 3, level_id: 3, answer_id: 210, numero: 45
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n The lemur is an unusual animal belonging to the same order than monkeys.", category_id: 3, level_id: 3, answer_id: 211, numero: 46
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n More and 90 percent of the calcium in the human body is in the skeleton.", category_id: 3, level_id: 3, answer_id: 212, numero: 47
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n Perhaps the most popular film in movie history, Star Wars was written and direction by George Lucas.", category_id: 3, level_id: 3, answer_id: 213, numero: 48
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n Some animal activities, such as mating, migration, and hibernate have a yearly cycle.", category_id: 3, level_id: 3, answer_id: 214, numero: 49
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n The cultures early of the genus Homo were generally distinguished by regular use of stone tools and by a hunting and gathering economy. ", category_id: 3, level_id: 3, answer_id: 215, numero: 50
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n The phonograph record was the first successful medium for capturing, preservation and reproducing sound. ", category_id: 3, level_id: 3, answer_id: 216, numero: 51
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n Generally, the pattern of open space in urban areas has shaped by commercial systems, governmental actions, and cultural traditions.", category_id: 3, level_id: 3, answer_id: 217, numero: 52
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n After first establishment subsistence farms along the Atlantic seaboard, European settlers in America developed a maritime and shipbuilding industry.", category_id: 3, level_id: 3, answer_id: 218, numero: 53
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n The legs of a roadrunner are enough strong that it can run up to 24 kilometers per hour to catch lizards and small rodents.", category_id: 3, level_id: 3, answer_id: 219, numero: 54
	DiagnosticTestQuestion.create enunciado: "The following sentence has four underlined words or phrases. Choose the one underlined word or phrase that must be changed for the sentence to be correct. \n For the immune system of a newborn mammal to develop properly, the 
	presence of  the thymus gland is essentially.", category_id: 3, level_id: 3, answer_id: 220, numero: 55
	DiagnosticTestQuestion.create enunciado: "Listen to the audio and DiagnosticTestAnswer the following DiagnosticTestQuestions \n How old was Monet when he painted the Garden at Saint-Andresse?", category_id: 4, level_id: 3, answer_id: 221, numero: 56
	DiagnosticTestQuestion.create enunciado: "Listen to the audio and DiagnosticTestAnswer the following DiagnosticTestQuestions \n The garden represented in the painting belongs to __________? ", category_id: 4, level_id: 3, answer_id: 222, numero: 57
	DiagnosticTestQuestion.create enunciado: "Listen to the audio and DiagnosticTestAnswer the following DiagnosticTestQuestions \n What did Monet demonstrate with this distinguished piece of art?", category_id: 4, level_id: 3, answer_id: 223, numero: 58
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “The garden represented in the painting belongs to Monet’s aunt, whose seaside villa was really close to the great port of Le Havre” \n seaside", category_id: 5, level_id: 3, answer_id: 224, numero: 59
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “Monet’s relations with his father were tense due to his family’s disapproval of his young affair with his companion, Camille”. \n disapproval", category_id: 5, level_id: 3, answer_id: 225, numero: 60
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “We can also appreciate Monet’s horizontal areas, which compress the composition in order to emphasize the two-dimensionality of the Garden at Saint-Andresse” \n emphasize", category_id: 5, level_id: 3, answer_id: 226, numero: 61
	DiagnosticTestQuestion.create enunciado: "Listen to the audio and DiagnosticTestAnswer the following DiagnosticTestQuestions \n What is the Mona Lisa?", category_id: 4, level_id: 3, answer_id: 227, numero: 62
	DiagnosticTestQuestion.create enunciado: "Listen to the audio and DiagnosticTestAnswer the following DiagnosticTestQuestions \n How is Mona Lisa’s expression?", category_id: 4, level_id: 3, answer_id: 228, numero: 63
	DiagnosticTestQuestion.create enunciado: "Listen to the audio and DiagnosticTestAnswer the following DiagnosticTestQuestions \n The Mona Lisa was painted during ______. ", category_id: 4, level_id: 3, answer_id: 229, numero: 64
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “The most written about and the most parodied work of art in the entire world. \n parodied", category_id: 5, level_id: 3, answer_id: 230, numero: 65
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “This painting of a woman, dressed in the Florentine fashion of her day and seated in a visionary, mountainous landscape, is a remarkable instance of Leonardo’s technique of soft, heavily shaded modelling.” \n remarkable", category_id: 5, level_id: 3, answer_id: 231, numero: 66
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “In fact, Mona Lisa’s enigmatic expression, which seems both alluring and aloof, has given the portrait a universal fame.” \n aloof", category_id: 5, level_id: 3, answer_id: 232, numero: 67
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n When did Kandinsky paint this masterpiece? ", category_id: 4, level_id: 3, answer_id: 233, numero: 68
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n Which technique was used in this painting?", category_id: 4, level_id: 3, answer_id: 234, numero: 69
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n Who is the real hero of the painting?", category_id: 4, level_id: 3, answer_id: 235, numero: 70
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “Regarding the painting itself, it was hand painted oil on canvas, it is categorized as an abstract oil painting and has been reproduced in different sizes by many other artists.” \n regarding", category_id: 5, level_id: 3, answer_id: 236, numero: 71
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “Kandinsky, in this period of his career, started painting pieces that quenched the needs of what he called his 'inner necessity. \n quenched", category_id: 5, level_id: 3, answer_id: 237, numero: 72
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “The sky and everything that appears in the painting are second and third fiddles, but color is the real hero of the masterpiece” \n fiddles", category_id: 5, level_id: 3, answer_id: 238, numero: 73
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n Where are the objects of real-life distributed? ", category_id: 4, level_id: 3, answer_id: 239, numero: 74
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n What is the one element in common between these ordinary things?", category_id: 4, level_id: 3, answer_id: 240, numero: 75
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n When was this artwork created?", category_id: 4, level_id: 3, answer_id: 241, numero: 76
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “The objects of real-life are distributed delicately in the restricted space between the edge of the table and the green curtain.” \n delicately", category_id: 5, level_id: 3, answer_id: 242, numero: 77
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “Picasso’s painting “Bread and Fruit Dish on a Table” still trails very narrowly the principles of the initial, monumental cubist period” \n narrowly", category_id: 5, level_id: 3, answer_id: 243, numero: 78
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “The cut threshold of the bread corresponds to the semi-circle of the table, there is a bowl of fruit and a cup upside down, as well as numerous pieces of fruit.” \n threshold", category_id: 5, level_id: 3, answer_id: 244, numero: 79
	DiagnosticTestQuestion.create enunciado: "Listen to these three conversation and then DiagnosticTestAnswer the following DiagnosticTestQuestions \n Helen and Jenny were offered to take a tour to the Statue of Liberty at the…", category_id: 4, level_id: 3, answer_id: 245, numero: 80
	DiagnosticTestQuestion.create enunciado: "Listen to these three conversation and then DiagnosticTestAnswer the following DiagnosticTestQuestions \n Why is Central park famous? ", category_id: 4, level_id: 3, answer_id: 246, numero: 81
	DiagnosticTestQuestion.create enunciado: "Listen to these three conversation and then DiagnosticTestAnswer the following DiagnosticTestQuestions \n How much will the tour cost for Jenny and Helen? ", category_id: 4, level_id: 3, answer_id: 247, numero: 82
	DiagnosticTestQuestion.create enunciado: "Listen to these three conversation and then DiagnosticTestAnswer the following DiagnosticTestQuestions \n Where are Kelly and Jenny staying? ", category_id: 4, level_id: 3, answer_id: 248, numero: 83
	DiagnosticTestQuestion.create enunciado: "Listen to these three conversation and then DiagnosticTestAnswer the following DiagnosticTestQuestions \n Where does Helen live? ", category_id: 4, level_id: 3, answer_id: 249, numero: 84
	DiagnosticTestQuestion.create enunciado: "Listen to these three conversation and then DiagnosticTestAnswer the following DiagnosticTestQuestions \n Why does Tom think that the girls will have so much fun at New York? ", category_id: 4, level_id: 3, answer_id: 250, numero: 85

	#Nivel E
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n I did not go ___________ yesterday.", category_id: 3, level_id: 4, answer_id: 251, numero: 1
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n - Where is Alison?  \n  - At home recovering __________ the flu.", category_id: 2, level_id: 4, answer_id: 252, numero: 2
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n  - The police finally solved the crime. \n   - Yes, the ringleader turned __________ his conspirators.", category_id: 2, level_id: 4, answer_id: 253, numero: 3
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n - What did the weather report say? \n     - That it __________ rain tomorrow.", category_id: 2, level_id: 4, answer_id: 254, numero: 4
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n - Sue is so rude.  \n     - I know.  She always barges __________ without knocking.", category_id: 2, level_id: 4, answer_id: 255, numero: 5
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n  - It's Barbara's last day of work on Friday. \n    - Let's chip in to buy her a _________ gift.", category_id: 1, level_id: 4, answer_id: 256, numero: 6
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n  - Did you go out with John last night?  \n      - Yes, and ____________, he asked me to go out again this coming. ", category_id: 3, level_id: 4, answer_id: 257, numero: 7
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n There has been a very ___________ change in the weather recently. ", category_id: 3, level_id: 4, answer_id: 258, numero: 8
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n In order to be a good parent, one must ____________ a caring attitude. ", category_id: 1, level_id: 4, answer_id: 259, numero: 9
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n The forest fire was ____________ by a carelessly discarded cigarette", category_id: 1, level_id: 4, answer_id: 260, numero: 10
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n He went to Hollywood in ____________ of becoming a famous actor.", category_id: 1, level_id: 4, answer_id: 261, numero: 11
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n This painting ___________ a battle in the Far East.", category_id: 3, level_id: 4, answer_id: 262, numero: 12
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n He told us  ___________ story about ghosts and monsters. ", category_id: 1, level_id: 4, answer_id: 263, numero: 13
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n There is ___________ of books on the subject. ", category_id: 1, level_id: 4, answer_id: 264, numero: 14
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n The mother is often awarded __________ of the children in divorce.", category_id: 1, level_id: 4, answer_id: 265, numero: 15
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n Your temperature has dropped, so you _________ take that antibiotic any longer.", category_id: 2, level_id: 4, answer_id: 266, numero: 16
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n Let me know as soon as Alice___________.", category_id: 3, level_id: 4, answer_id: 267, numero: 17
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n It's the third time we__________ this film.", category_id: 2, level_id: 4, answer_id: 268, numero: 18
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n - \"What happened with Jodie's project for the science fair?\"      - \"It _______________ an award for the most creative presentation. \"", category_id: 2, level_id: 4, answer_id: 269, numero: 19
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n There's ________ good on TV tonight.", category_id: 3, level_id: 4, answer_id: 270, numero: 20
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n Everyone in the bank -including the manager and the tellers, ran to the door when the fire alarm rang.", category_id: 3, level_id: 4, answer_id: 271, numero: 21
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n In studying an assignment it is wise to read it over quickly at first, than see the major points, and finally outline the material.", category_id: 3, level_id: 4, answer_id: 272, numero: 22
	DiagnosticTestQuestion.create enunciado: "Complete the sentence choosing a, b or c. \n A moth possesses two pairs of wings ___________as a single pair and are covered with dust like scales.", category_id: 3, level_id: 4, answer_id: 273, numero: 23
	DiagnosticTestQuestion.create enunciado: "Complete the following sentence with the words given in parenthesis. Use the form of the word that fits in the space. \n She comes from a _________________ family", category_id: 3, level_id: 4, answer_id: 274, numero: 24
	DiagnosticTestQuestion.create enunciado: "Complete the following sentence with the words given in parenthesis. Use the form of the word that fits in the space. \n Camila is _______________ to become a lawyer soon.", category_id: 3, level_id: 4, answer_id: 275, numero: 25
	DiagnosticTestQuestion.create enunciado: "Complete the following sentence with the words given in parenthesis. Use the form of the word that fits in the space. \n The shop _______________ was terribly busy that day.", category_id: 1, level_id: 4, answer_id: 276, numero: 26
	DiagnosticTestQuestion.create enunciado: "Complete the following sentence with the words given in parenthesis. Use the form of the word that fits in the space. \n The _______________ is very good.", category_id: 1, level_id: 4, answer_id: 277, numero: 27
	DiagnosticTestQuestion.create enunciado: "Complete the following sentence with the words given in parenthesis. Use the form of the word that fits in the space. \n This book seems to be ________________. ", category_id: 1, level_id: 4, answer_id: 278, numero: 28
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n The hotel and the food were very different ___________ what I expected.", category_id: 3, level_id: 4, answer_id: 279, numero: 29
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n Do you believe ____________ God?", category_id: 3, level_id: 4, answer_id: 280, numero: 30
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n You are so kind, you remind me ____________ my mother.", category_id: 3, level_id: 4, answer_id: 281, numero: 31
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n This is related ____________ my personal affairs.", category_id: 3, level_id: 4, answer_id: 282, numero: 32
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n That lady is in charge ____________ all the technical aspects.", category_id: 3, level_id: 4, answer_id: 283, numero: 33
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n You mean a lot _____________ me. ", category_id: 3, level_id: 4, answer_id: 284, numero: 34
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n Inform me ____________ your final decision.", category_id: 3, level_id: 4, answer_id: 285, numero: 35
	DiagnosticTestQuestion.create enunciado: "Choose the correct preposition to complete the sentence. \n Did you write it ______________ hand (in/by)?", category_id: 3, level_id: 4, answer_id: 286, numero: 36
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word that creates a mistake in the sentence. \n The man which works here is from Mexico.", category_id: 3, level_id: 4, answer_id: 287, numero: 37
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word that creates a mistake in the sentence. \n I can to dance tango well.", category_id: 3, level_id: 4, answer_id: 288, numero: 38
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word that creates a mistake in the sentence. \n I am married with the perfect man.", category_id: 3, level_id: 4, answer_id: 289, numero: 39
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word that creates a mistake in the sentence. \n I was boring in yesterday's lecture.", category_id: 3, level_id: 4, answer_id: 290, numero: 40
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word that creates a mistake in the sentence. \n I enjoyed from the movie.", category_id: 3, level_id: 4, answer_id: 291, numero: 41
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word that creates a mistake in the sentence. \n I've been here since three months. ", category_id: 3, level_id: 4, answer_id: 292, numero: 42
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word that creates a mistake in the sentence. \n You speak English good.", category_id: 3, level_id: 4, answer_id: 293, numero: 43
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word that creates a mistake in the sentence. \n Do you like a glass of water? ", category_id: 3, level_id: 4, answer_id: 294, numero: 44
	DiagnosticTestQuestion.create enunciado: "Choose the underlined word that creates a mistake in the sentence. \n I didn't go nowhere", category_id: 3, level_id: 4, answer_id: 295, numero: 45
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n What happened in Da Vinci’s fifth birthday?", category_id: 4, level_id: 4, answer_id: 296, numero: 46
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n What was “The Adoration of Magi”? ", category_id: 4, level_id: 4, answer_id: 297, numero: 47
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n Which of these features can be considered Da Vinci’s weak point?", category_id: 4, level_id: 4, answer_id: 298, numero: 48
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “It was there, where Da Vinci began to use his knowledge in science to enhance his paintings” \n enhance", category_id: 5, level_id: 4, answer_id: 299, numero: 49
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n During his apprenticeship, he began to find his niche at investing machines such as submarine, helicopter, and diving suit. \n apprenticeship", category_id: 5, level_id: 4, answer_id: 300, numero: 50
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n Once Leonardo finished his education, he stayed in Verrochio’s workshop, until 1477 when he set up his own studio. \n set up", category_id: 5, level_id: 4, answer_id: 301, numero: 51
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives. \n What is the title of this painting associated with?", category_id: 4, level_id: 4, answer_id: 302, numero: 52
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives. \n What is created by circles, triangles and linear elements?", category_id: 4, level_id: 4, answer_id: 303, numero: 53
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives. \n What tendency is found in this painting?", category_id: 4, level_id: 4, answer_id: 304, numero: 54
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “In which the constant repetition of elements reinforces the idea of musical elements being played at the same time.” \n reinforces", category_id: 5, level_id: 4, answer_id: 305, numero: 55
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “The first ones imply movement, whereas the others remain as a sign of stability.” \n remain", category_id: 5, level_id: 4, answer_id: 306, numero: 56
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives. \n What makes Guernica a personal work?", category_id: 4, level_id: 4, answer_id: 307, numero: 57
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives. \n What is the meaning of the word “Guernica”?", category_id: 4, level_id: 4, answer_id: 308, numero: 58
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives. \n What does Guernica represent?", category_id: 4, level_id: 4, answer_id: 309, numero: 59
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “Guernica” is principally a war painting, offering the viewer a pictorial account of the overwhelming and chaotic impact of war on both men and women, in this case definitely on citizen life and communities.” \n Overhelming", category_id: 5, level_id: 4, answer_id: 310, numero: 60
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “Picasso finished the masterpiece in 1937, a time of widespread political disturbance not just in Spain, but internationally.” \n widespread", category_id: 5, level_id: 4, answer_id: 311, numero: 61
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “A figure sprawled supine in the focal point of the painting seems to be a corpse and it is surrounded, on both sides, by living victims with their heads thrown backs, waiting in misery and agony” \n waiting", category_id: 5, level_id: 4, answer_id: 312, numero: 62
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between three people and DiagnosticTestAnswer the following DiagnosticTestQuestions. \n Why does Francisco have the account book?", category_id: 4, level_id: 4, answer_id: 313, numero: 63
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between three people and DiagnosticTestAnswer the following DiagnosticTestQuestions. \n Why does Constanza need help? ", category_id: 4, level_id: 4, answer_id: 314, numero: 64
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between three people and DiagnosticTestAnswer the following DiagnosticTestQuestions. \n Why is Constanza happy?", category_id: 4, level_id: 4, answer_id: 315, numero: 65
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between three people and DiagnosticTestAnswer the following DiagnosticTestQuestions. \n Could Roberto find Francisco?", category_id: 4, level_id: 4, answer_id: 316, numero: 66
	DiagnosticTestQuestion.create enunciado: "Listen to the conversation between three people and DiagnosticTestAnswer the following DiagnosticTestQuestions. \n What does Roberto need to do?", category_id: 4, level_id: 4, answer_id: 317, numero: 67
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n This artwork was painted in _______? ", category_id: 4, level_id: 4, answer_id: 318, numero: 68
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n Where did Van Gogh paint this artwork?", category_id: 4, level_id: 4, answer_id: 319, numero: 69
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n What does the painting describe?", category_id: 4, level_id: 4, answer_id: 320, numero: 70
	DiagnosticTestQuestion.create enunciado: "Listen to the following audio and choose the correct alternatives \n What type of movement is used by Van Gough in this artwork?", category_id: 4, level_id: 4, answer_id: 321, numero: 71
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “The painting describes a natural countryside consisting of a wheat field cypress trees, withdrawn mountains, and a cloud sky” \n withdrawn", category_id: 5, level_id: 4, answer_id: 322, numero: 72
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “Most part of the painting is decorated with middle tones with the exclusion of the dark ones, contrasting cypress trees” \n exclusion", category_id: 5, level_id: 4, answer_id: 323, numero: 73
	DiagnosticTestQuestion.create enunciado: "According to the listening, choose the alternative that best represents the meaning of the underlined word in the following sentences \n “There is cold colour domination throughout the artwork, except for the warm yellow, green, and blue with green being the dominate colour.” \n throughout", category_id: 5, level_id: 4, answer_id: 324, numero: 74


	##Ingreso de datos a respuestas
	#Nivel AB
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "red", b: "yellow", c: "orange", d: "purple"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "green", b: "light blue", c: "red", d: "grey"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "green", b: "blue", c: "black", d: "orange"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "orange", b: "turquoise", c: "blue", d: "yellow"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "cat", b: "dog", c: "bird", d: "horse"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "flowers", b: "cellphone", c: "bed", d: "house"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "girl", b: "boy", c: "car", d: "tree"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "cheese", b: "milk", c: "tomato", d: "oregano"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "to cook", b: "to sing", c: "to draw", d: "to sleep"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "jumps", b: "eats", c: "speaks", d: "makes"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "are", b: "am", c: "were", d: "is"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "are", b: "am", c: "were", d: "is"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "are", b: "am", c: "were", d: "is"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "are", b: "am", c: "were", d: "is"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "is", b: "are", c: "was", d: "am"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "do", b: "take ", c: "will", d: "does"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "business", b: "eat", c: "buy", d: "doesn’t"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "is", b: "are", c: "be", d: ""
	DiagnosticTestAnswer.create num_resp: 3, correcta: "d", a: "deciding", b: "decided", c: "decides", d: ""
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "she does did it last week.", b: "the students work in groups", c: "you told me that story", d: "I go there everyday"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "where the nearest bank is?", b: "how many tribes live there?", c: "what time is it?", d: "where is your jacket?"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "my children are intelligent", b: "we has a big pool", c: "he is nice", d: "their dogs are pretty"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "we lost the game", b: "we have a party", c: "there is no concert because rain", d: "you need to read the news "
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "someone gives the school mice ", b: "some one gives the school mice", c: "some one gives to the school mice ", d: "there is a person that gives the school mice ", e: ""
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "is the best pets. ", b: "could be the best pets. ", c: "are of the best pets ", d: "are the best pets.", e: ""
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "move", b: "purr", c: "growl", d: "migrate", e: ""
	DiagnosticTestAnswer.create num_resp: 5, correcta: "e", a: "sunk", b: "did sink ", c: "was sunk", d: "did sank", e: "sank"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "hers", b: "his", c: "she"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "mine", b: "our", c: "them"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "my", b: "it", c: "mine"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "mine", b: "your", c: "he"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "their", b: "his", c: "her"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "elevation", b: "foot", c: "sea"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "her", b: "he", c: "go"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "the", b: "write", c: "de"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "A", b: "are", c: "information"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "liked", b: "likes", c: "life"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "went", b: "mother", c: "go"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "worked", b: "works", c: "working"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "is", b: "has", c: "are"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "am", b: "have", c: "are"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "I", b: "am", c: "she"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "does", b: "is", c: "do"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "was", b: "are", c: "be"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "has", b: "am", c: "are"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "make", b: "do", c: "have"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "him", b: "his", c: "he"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "Yours", b: "Your", c: "You"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "They", b: "Ours", c: "Our"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "the", b: "a", c: "an", d: "ø"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "The", b: "A", c: "An", d: "ø"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "The", b: "A", c: "An", d: "ø"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "the", b: "a", c: "an", d: "ø"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "the", b: "a", c: "an", d: "ø"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "the", b: "a", c: "an", d: "ø"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "elephant", b: "cat", c: "deer", d: "dog"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "red", b: "blue", c: "mellow", d: "me"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "she", b: "they", c: "dog", d: "your"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "a", b: "some", c: "any", d: "an"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "this", b: "that", c: "those"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "much", b: "many", c: "a"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "This", b: "That", c: "These"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "The", b: "ø", c: "Much"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "many", b: "some", c: "much"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "dig", b: "think about ", c: "think of ", d: "admire "
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "effect the story's plot ", b: "effects the stories plot ", c: "affect the story's plot", d: "affects the story's plot"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "many", b: "any", c: "a lot"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "hats", b: "It’s", c: "with"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "It’s", b: "not", c: "you "
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "do", b: "mine", c: "homework"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "I", b: "work", c: "days"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "That", b: "girl", c: "much"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "This", b: "is", c: "his"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "I", b: "an", c: "doctor"
	DiagnosticTestAnswer.create num_resp: 2, correcta: "a", a: "on", b: "in"
	DiagnosticTestAnswer.create num_resp: 2, correcta: "a", a: "at", b: "in"
	DiagnosticTestAnswer.create num_resp: 2, correcta: "b", a: "to", b: "on"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "a in the basement of the old house", b: "b in a old park", c: "c in the living room of the old house"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "children playing football", b: "a forest full of colorful trees and animals", c: "a boat and behind it a city full of tiny houses."
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "Kandinsky", b: "Picasso", c: "Miro"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "The room of the house in which we eat", b: "The room of a house in which we sleep", c: "The room of the house which is under the ground floor"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "a kind of food", b: "a kind of music", c: "a season of the year"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "bright and full of energy", b: "boring and with dark colors", c: "dull and sad"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "Alex and John", b: "Jack and Axel", c: "Jack and Alex"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "every Saturday", b: "every summer", c: "every day"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "hungary", b: "hungry", c: "mad"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "sick", b: "angry", c: "sad"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "food for cows", b: "something to eat", c: "something to drink"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "now", b: "this day", c: "always"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "Russia", b: "France", c: "Belarus"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "beautiful", b: "concentric", c: "exquisite"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "passion", b: "enjoyment", c: "intensity"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "personal", b: "special", c: "peculiar"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "composition", b: "format", c: "example"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "Christmas", b: "Thanksgiving ", c: "Her birthday"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "balloons, confetti and food", b: "flowers, books and adults", c: "clowns, magicians and singers"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "her father gave her a dog as a present", b: "her mother gave her a beautiful doll as a present", c: "her friends are arriving and they bring her a lot of birthday presents"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "happy and enthusiastic ", b: "sad and melancholic", c: "bored and lazy"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "something to eat", b: "something to drink", c: "small pieces of colorful papers that people throw in parties, celebrations or parades"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "a fruit flavour", b: "a cookie", c: "a type of cake"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "he was training his dog ", b: "he was doing the laundry", c: "he was watering his flowers"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "grandpa George, when he was a little boy", b: "the grandfather of grandpa George", c: "the grandchildren of grandpa George."
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "a little fruit and vegetable orchard in the back garden of his house", b: "his beautiful flowers and his oak tree", c: "an old coin that his grandfather wore as a necklace and a picture of him."
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "important and special", b: "expensive and beautiful", c: "useful and old"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "a type of tree", b: "the color of the tree", c: "an animal"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "a color", b: "a metal", c: "a game"

	#Nivel C
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "cheese", b: "house", c: "computer", d: "pencil"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "does it for me", b: "does it me", c: "does it to me", d: "s doing it for me"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "has ", b: "have", c: "is", d: "calls"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "Does ", b: "Are", c: "Do", d: "Were"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "was happening", b: "has happening", c: "happened", d: "happen"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "goes", b: "going", c: "go"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "tallest of the", b: "taller than her", c: "taller of her", d: "most tall of the"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "inhaling", b: "exhaling ", c: "gnawing", d: "respiring"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "dairy", b: "flock", c: "livestock", d: "breed"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "hitches", b: "harnesses", c: "bridles", d: "blinders"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "lashing", b: "coaxing ", c: "cultivating", d: "irrigating"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "sprout", b: "vicious", c: "stout", d: "prone"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "contrition", b: "bargain", c: "weary", d: "dingy"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "illicit", b: "prudent", c: "genial", d: "witty"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "the driest", b: "the most dry", c: "driest"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "like other animals", b: "how other animals", c: "other animals that", d: "do other animals"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "the", b: "a", c: "an", d: "nothing"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "more older", b: "older", c: "many older"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "much", b: "many", c: "any"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "younger", b: "youngest", c: "young"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "tallest", b: "the tallest", c: "taller"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "relaxed", b: "relaxing", c: "more relaxed"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "faster", b: "the fastest", c: "fastest"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "expensive", b: "expensiver", c: "more expensive"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "fastest", b: "fasten", c: "faster"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "has", b: "had", c: "have"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "tells", b: "tell", c: "told"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "was", b: "were", c: "is"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "buys", b: "is buying", c: "was buying"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "heard", b: "hears", c: "hear"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "lookes", b: "looks", c: "looked"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "bump", b: "bumped", c: "bumping"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "is sleeping", b: "was sleeping", c: "sleeping"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "fells", b: "fell", c: "feel"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "took", b: "taken", c: "take"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "happen", b: "happens", c: "happened"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "the northern lands", b: "the southern lands", c: "the eastern lands"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "low part of the artwork", b: "high part of the artwork", c: "middle part of the artwork"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "still", b: "tilted to the side", c: "moving"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "music", b: "war", c: "painting"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "a surface of interacting geometric forms", b: "isolated geometric forms", c: "geometric forms that represent life"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "colors", b: "opposites", c: "stability"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "enlarge", b: "prop", c: "emphasize"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "delay", b: "stand", c: "dwell"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "its connection to Picasso’s home", b: "its representation of Paris", c: "its illustrious character"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "a kind of bomb", b: "a torture exercise", c: "a small town"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "the confusion lived in Spain at that time", b: "violence and victims of war", c: "bodies with cubist shapes"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "compulsive", b: "devastating", c: "unbearable"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "popular", b: "pervasive", c: "universal"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "grieving", b: "bowling", c: "crying"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "he was comparing some signatures", b: "he was copying some vouchers", c: "Francisco does not have it"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "she does not know where the third floor is", b: "she has to go to the safe", c: "she has to go to the safe"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "because she has a good team", b: "because she likes her job", c: "because she is a novice"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "yes, he could", b: "no, because he was not in the office", c: "no, but he could ask someone else for help"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "see the wall-graphs", b: "know his clients", c: "check the percentages"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "evening", b: "afternoon", c: "morning"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "lots of thunder", b: "showers", c: "thick fog"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "they hear a clap of thunder", b: "the elevator breaks down", c: "they see a lighting "
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "Salvador", b: "Patricio", c: "Priscilla"

	#Nivel D
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "to go", b: "going", c: "to going", d: "to have been going"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "shortage", b: "shortage of", c: "a shortage of", d: "the shortage of"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "by which transmits", b: "by which are transmitted ", c: "which are transmitted", d: "which transmits"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "lived", b: "that living", c: "who living", d: "living"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "that", b: "which", c: "when", d: "where"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "gait", b: "punch", c: "loot", d: "stumbling block"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "on summer ", b: "in summer", c: "during summers", d: "summertime"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "I am interesting", b: "I am interested", c: "Interesting it is", d: "It is interesting"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "to sew ", b: "to sewing", c: "she sews", d: "she sewing"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "herbivorous", b: "deciduous ", c: "carnivorous", d: "agrarian"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "debris", b: "jetty", c: "relic", d: "treaty"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "deluge", b: "ambush", c: "effigy", d: "crevice"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "am going", b: "went", c: "was going"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "must", b: "ought", c: "could", d: "maybe"
	DiagnosticTestAnswer.create num_resp: 2, correcta: "b", a: "take", b: "taking"
	DiagnosticTestAnswer.create num_resp: 2, correcta: "a", a: "is going to", b: "will"
	DiagnosticTestAnswer.create num_resp: 2, correcta: "b", a: "might", b: "will"
	DiagnosticTestAnswer.create num_resp: 2, correcta: "b", a: "will arrive", b: "arrives"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "while", b: "until", c: "on", d: "when"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "by", b: "in", c: "on"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "for", b: "since", c: "until"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "since", b: "for", c: "by"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "of", b: "from", c: "for"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "shop", b: "shopping", c: "shopped"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "awfully", b: "awful", c: "awfuled"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "reasoning", b: "reason", c: "reasonable"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "cheap", b: "cheaper", c: "cheapest"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "assistant", b: "assistants", c: "asisstanters"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "friendly", b: "friender", c: "friend"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "measuring", b: "measurements", c: "measures"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "Fortuning", b: "Fortunately", c: "Fortunely"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "managing", b: "management", c: "manager"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "converting", b: "convertion", c: "converse"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "designer", b: "designly", c: "designing"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "was going to visit", b: "am going to visit", c: "visit"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "can’t", b: "couldn’t", c: "not could"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "gets", b: "is getting", c: "got"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "felt", b: "feeled", c: "fell"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "was calling", b: "had called", c: "were called"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "had going", b: "gone", c: "was going"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "happened", b: "happening", c: "happen"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "am coming", b: "was coming", c: "will come"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "The flowering", b: "in", c: "art", d: "to know"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "After", b: "dry", c: "are obtained", d: "use"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "particles comprising", b: "continually changing", c: "are taking", d: "moving air"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "an unusual", b: "belonging to", c: "same", d: "than"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "and", b: "human", c: "is", d: "the"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "Perhaps", b: "popular", c: "in movie", d: "direction"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "Some", b: "such", c: "hibernate", d: "yearly"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "cultures early", b: "regular", c: "stone tools", d: "economy"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "The", b: "successful", c: "preservation", d: "sound"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "Generally", b: "open space", c: "has shaped", d: "governmental actions"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "establishment", b: "along", c: "settlers", d: "industry"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "enough strong", b: "can run", c: "up to", d: "to catch"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "For", b: "to develop", c: "the presence", d: "essentially"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "62", b: "26", c: "32"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "Monet’s sister Sophie", b: "Monet’s uncle", c: "Monet’s aunt"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "his new depiction of modern life", b: "his maturity", c: "his love towards his new companion, Camille"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "an area close to a river", b: "an area by the sea", c: "an area with a salty water"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "objection", b: "blame", c: "criticism"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "limelight", b: "accentuate", c: "headline"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "a portrait", b: "a woman", c: "reinassance"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "enigmatic", b: "happy", c: "sad"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "the Medieval Times", b: "the Reinassance period", c: "modern times"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "mock", b: "satirize", c: "impersonate"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "noteworthy", b: "miraculous", c: "exceptional"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "indifferent", b: "unresponsive", c: "above"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "908", b: "1908", c: "9008"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "oil on canvas", b: "tempera", c: "pencil"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "fiddles", b: "the sky", c: "color"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "respecting", b: "in relation", c: "about"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "destruct", b: "demolish", c: "satisfy"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "doodle", b: "monkey", c: "toy"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "between the edge of the table and the green curtain", b: "between the two legs of the table", c: "under the table"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "they are all creating a contrast between the table and the green curtain", b: "they are all round figures", c: "they comply with certain geometrical cannons"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "1809", b: "1909", c: "1908"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "cautiosly", b: "elegantly", c: "gracefully"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "barely", b: "carefully", c: "almost"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "brink", b: "down", c: "edge"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "museum", b: "City Hall", c: "airport"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "for its reservoir, the zoological garden, and the pond", b: "artificial lake, the zoological garden, and the fountain", c: "its reservoir, the zoological garden, and the fountain"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "$US 70", b: "$US 140", c: "$US 157"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "City Hall", b: "Tom’s house", c: "Lincoln Street"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "New York", b: "Spain", c: "France"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "so many places to visit", b: "it is the city that never sleeps", c: "it’s such a big city"

	#Nivel E
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "nowhere", b: "somewhere", c: "anywhere"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "with", b: "for", c: "to", d: "from"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "down", b: "away ", c: "off", d: "against"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "must", b: "ought", c: "could", d: "maybe"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "in", b: "on", c: "around", d: "about"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "going", b: "off", c: "farewell", d: "apologize"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "in surprise", b: "surprising", c: "surprisingly", d: "surprised"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "profuse ", b: "perceptible", c: "confined", d: "imperative"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "regress", b: "foster", c: "snub", d: "stifle"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "a", a: "ignited", b: "retired ", c: "submerged", d: "forged"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "frail", b: "fringe", c: "quest", d: "gait"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "strands ", b: "depicts", c: "engulfs", d: "repels"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "d", a: "a lush", b: "a jagged ", c: "a staunch", d: "an eerie"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "a congruity", b: "a parameter ", c: "an overabundance", d: "a jurisdiction"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "b", a: "ransom", b: "custody", c: "interment", d: "testimony"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "don't need to", b: "need not", c: "must not"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "is arriving", b: "arrives", c: "will arrive"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "have seen", b: "had seen", c: "are seeing"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "gave", b: "has given", c: "was given", d: "was giving"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "nothing", b: "anything", c: "no"
	DiagnosticTestAnswer.create num_resp: 5, correcta: "d", a: "Tellers, ran", b: "tellers: ran ", c: "tellers, had run ", d: "tellers-ran ", e: "tellers\' ran\""
	DiagnosticTestAnswer.create num_resp: 5, correcta: "d", a: "first, than ", b: "first: then ", c: "first-then ", d: " first, then ", e: "first-than"
	DiagnosticTestAnswer.create num_resp: 4, correcta: "c", a: "function", b: "are functioning ", c: "that function ", d: "but functions "
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "scientist", b: "scientific", c: "science"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "hoping", b: "hope", c: "hopes"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "assistent", b: "assistant", c: "assistanter"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "painter", b: "paint", c: "painted"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "interested", b: "interesting", c: "interest"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "of", b: "from", c: "out"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "on", b: "to", c: "in"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "in", b: "of", c: "to"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "to", b: "with", c: "in"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "off", b: "for", c: "of"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "to", b: "for", c: "at"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "in", b: "on", c: "of"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "in", b: "by", c: "on"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "man", b: "which", c: "from"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "can", b: "to", c: "well"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "am", b: "married", c: "with"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "boring", b: "yesterday’s", c: "lecture"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "enjoyed", b: "from", c: "movie"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "I’ve", b: "been", c: "since"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "speak", b: "English", c: "good"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "Do", b: "like", c: "water"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "didn’t", b: "go", c: "nowhere"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "he moved from his father’s house", b: "he was received in his father’s house", c: "his mother became wealthy"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "his first work in Florence", b: "an offer from the Duke of Milan", c: "his first finished work of art"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "he is a symbol of the “Reinassance Man”", b: "he was not exceptional in some areas", c: "he could not complete his works "
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "amplify", b: "improve", c: "swell"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "preparation", b: "training", c: "refinement"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "establish", b: "organize", c: "compose"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "music", b: "war", c: "painting"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "a surface of interacting geometric forms", b: "isolated geometric forms", c: "geometric forms that represent life"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "colors", b: "opposites", c: "stability"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "enlarge", b: "prop", c: "emphasize"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "delay", b: "stand", c: "dwell"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "its connection to Picasso’s home", b: "its representation of Paris", c: "its illustrious character"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "a kind of bomb", b: "a torture exercise", c: "a small town"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "the confusion lived in Spain at that time", b: "violence and victims of war", c: "bodies with cubist shapes"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "compulsive", b: "devastating", c: "unbearable"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "popular", b: "pervasive", c: "universal"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "grieving", b: "bowling", c: "crying"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "he was comparing some signatures", b: "he was copying some vouchers", c: "Francisco does not have it"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "she does not know where the third floor is", b: "she has to go to the safe", c: "she needs to find Francisco"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "because she has a good team", b: "because she likes her job", c: "because she is a newbie"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "yes, he could", b: "no, because he was not in the office", c: "no, but he could ask someone else for help"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "see the wall-graphs", b: "know his clients", c: "check the percentages"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "September 1889", b: "November 1889", c: "September 1898"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "in Saint-Paul-de-Mausole", b: "in Arles", c: "in the countryside"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "a peaceful ocean", b: "a natural countryside", c: "the characteristics of the wind"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "Impressionism", b: "Classical Realism", c: "Cubism"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "c", a: "silent", b: "solitary", c: "distant"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "a", a: "omission", b: "elimination", c: "prohibition"
	DiagnosticTestAnswer.create num_resp: 3, correcta: "b", a: "every bit", b: "all over", c: "everywhere"
  end
end