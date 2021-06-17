require_relative '../app/pet.rb'

describe do
    subject(:pet) { Pet.new }
    let(:body_pets) { attributes_for(:attr_pet) }
    
    context 'EXTRA' do
        it 'DOTENV' do #TODO: Teste básico nos campos do DOTENV
            puts ENV['BASE_URI']
            puts ENV['USER_NAME']
            puts ENV['PASSWORD']
        end
        it 'FACTORY_BOT' do #TODO: Validando a factory e exibindo junto ao body ideal que as APIs utilizam
            puts body_pets  #Factory :attr_pet
            puts body_pets.to_json
            puts body = { 
                "id": 0,
                "category": {"id": 0, "name": "TESTE_GET_ONE"},
                "name": "N_TESTE_ONE", 
                "photoUrls": [""],
                "tags": [{"id": 0,"name": "TESTE_TAG_ONE"}],
                "status": "available"
            }.to_json
        end
    end

    context 'C.R.U.D. PETs' do
        it 'CREATE' do #CRIANDO #TODO: Cria um registro unico de PET
            resultado = pet.create(body_pets.to_json) #Criando um registro para podermos testar o GET sem necessidade de ficar informando os parametros
            expect(resultado.code).to eq(200)
            puts resultado #Exibindo valores criados para checkar

            body_invalido = {}
            resultado_invalido = pet.create(body_invalido.to_json)
            expect(resultado_invalido.code).to eq(200) #? Por que ele me retornou 200 em um body inválido? está correto este comportamento?
            puts "Criação Inválida:  #{resultado_invalido}"
        end
        
        it 'READ LIST' do #TODO: Lê todos os registros de PETs por status
            status = ['available', 'pending', 'sold', 'status_invalido']
            #? Criar uma varial como a 'resultado_available' para guardar cada retorno é o ideal? ou é melhor usar somente uma (ex.: 'resultado')?
            resultado_available = pet.read_all(status[0]) #Lendo todos os registros com status = 'available'
            expect(resultado_available.code).to eq(200)

            resultado_pending = pet.read_all(status[1]) #Lendo todos os registros com status = 'pending'
            expect(resultado_pending.code).to eq(200)

            resultado_sold = pet.read_all(status[2]) #Lendo todos os registros com status = 'sold'
            expect(resultado_sold.code).to eq(200)

            resultado_invalido = pet.read_all(status[3]) #Lendo todos os registros com status = 'status_invalido'
            expect(resultado_invalido.code).to eq(200) #? Por que ele me retorna 200 em um status que não existe? está correto este comportamento?
            puts "Retorno do Status Inválido: #{resultado_invalido}"

            resultado_criacao = pet.create(body_pets.to_json) #Criando um registro para podermos testar o GET sem necessidade de ficar informando os parametros
            expect(resultado_criacao.code).to eq(200)
            puts resultado_criacao #Exibindo resultado apenas para checkar
            puts resultado_criacao.select { | busca | busca['name'] == body_pets['name'] } #Confirmando que os valores foram salvos corretamente
        end
        it 'READ ONE' do #TODO: Lê um registro único de PET + Criação do registro buscado 
            resultado_criacao = pet.create(body_pets.to_json) #Criando um registro para podermos testar o GET sem necessidade de ficar informando os parametros
            expect(resultado_criacao.code).to eq(200)
            puts resultado_criacao #Exibindo resultado apenas para checkar
            
            resultado = pet.read(resultado_criacao['id'].to_json) #GET com o ID capturado na criação deste registro
            expect(resultado.code).to eq(200)
            puts "RESULTADO DA BUSCA: #{resultado}"
        end
        it 'UPDATE' do #TODO: Atualiza um registro único de PET + Criação deste registro
            resultado_criacao = pet.create(body_pets.to_json) #Criando um registro para podermos testar o GET sem necessidade de ficar informando os parametros
            expect(resultado_criacao.code).to eq(200)
            puts resultado_criacao #Exibindo resultado apenas para checkar
            body_atualizado = { #? Como faço para utilizar a factory nesse caso? a dificildade é: atualizar os valores "tags" sem usar um "body{}" desta maneira
                "id": resultado_criacao['id'],
                "category": {"id": 0, "name": "TESTE_GET_ONE_ATUALIZADO"},
                "name": "N_TESTE_ONE_ATUALIZADO", 
                "photoUrls": [""],
                "tags": [{"id": 0,"name": "TESTE_TAG_ONE_ATUALIZADO"}],
                "status": "available"
            }.to_json
            resultado_update = pet.update(body_atualizado)
            expect(resultado_update.code).to eq(200)
            puts resultado_update
        end
        # it 'UPDATE (POST)' do #! NÃO ESTÁ FUNCIONANDO AINDA
        #     resultado_criacao = pet.create(body_pets.to_json) #Criando um registro para podermos testar o GET sem necessidade de ficar informando os parametros
        #     expect(resultado_criacao.code).to eq(200)
        #     puts resultado_criacao #Exibindo resultado apenas para checkar

        #     #formData = FormData.new()
        #     #subject(:formData) { FormData.new }
        #     #formData.append = name = 'TESTEFORMDATA', status = 'available'
        #     #form_data = 'name=TESTE&status=available'
        #     resultado = pet.update_data(resultado_criacao['id'])
        #     expect(resultado.code).to eq(405)
        # end
        it 'DELETE' do #!FUNCIONAL PORÉM NEM SEMPRE, NO SWAGGER PRECISAMOS RODAR A API MAIS DE UMA VEZ PARA TERMOS SUCESSO
            resultado_criacao = pet.create(body_pets.to_json) #Criando um registro para podermos testar o GET sem necessidade de ficar informando os parametros
            expect(resultado_criacao.code).to eq(200)
            puts resultado_criacao #Exibindo resultado apenas para checkar
            resultado_delete = pet.delete(resultado_criacao['id'].to_json)
            expect(resultado_delete.code).to eq(200)
        end
    end
end