# frozen_string_literal: true

require "redi_search/search/clauses/application_clause"

module RediSearch
  class Search
    module Clauses
      class SortBy < ApplicationClause
        clause_term :field, presence: true
        clause_term :order, presence: true, inclusion: { within: %i(asc desc) }

        def initialize(field:, order: :asc)
          @field = field
          @order = order.to_sym
        end

        def clause
          validate!

          ["SORTBY", field, order]
        end
      end
    end
  end
end
