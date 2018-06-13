# frozen_string_literal: true

module V1
  module Private
    class PricingController < PrivateBaseController
      def evaluate_target
        trgt = Target.new(eval_params.fetch(:country_code),
                          eval_params.fetch(:target_group_id),
                          eval_params.fetch(:locations))

        if trgt.valid?
          render json: {
            price: trgt.eval
          }
        else
          render json: { errors: trgt.errors }, status: :unprocessable_entity
        end
      end

      private

      def eval_params
        params.permit(:country_code, :target_group_id, locations: %i[id size])
      end
    end
  end
end
