require_relative '../models/obj_pet.rb'
require_relative '../models/obj_category.rb'
require_relative '../models/obj_tag.rb'

FactoryBot.define do
    
    factory :attr_pet, aliases: [:attr_pet_padrao], class: Obj_pet do
        id                  { 0 }
        category            {attributes_for(:attr_cat)}
        name                {'TESTE_NAME'}
        photoUrls           { ['string'] }
        tags                {[attributes_for(:attr_tag)]}
        status              {'available'}
    end

    factory :attr_cat, class: Obj_category do
        id                  { 12345678 }
        name                {'TESTE_CATEGORY'}
    end

    factory :attr_tag, class: Obj_tag do
        id                  { 98765432 }
        name                {'TESTE_TAG'}
    end

end

        # body = { 
        #     "id": 0,
        #     "category": {"id": 0, "name": "TESTE_GET_ONE"},
        #     "name": "N_TESTE_ONE", 
        #     "photoUrls": [""],
        #     "tags": [{"id": 0,"name": "TESTE_TAG_ONE"}],
        #     "status": "available"
        # }

# factory :attr_pet, aliases: [:attr_pet_padrao], class: Obj_pet do
        # id                  { 0 }
        # category            {[id {0} , name {"TESTE_GET_ONE"}]}
        # name                {'N_TESTE_ONE'}
        # photoUrls           {['']}
        # tags                {[id {0}, name {"TESTE_TAG_ONE"}]}
        # status              {'available'}