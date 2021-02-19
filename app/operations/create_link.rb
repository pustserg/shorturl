class CreateLink
  URL_REGEX = %r{http(s?)://\w+\.\w+}.freeze
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    return unless valid?

    Retriable.retriable(on: ActiveRecord::RecordNotUnique, tries: 5) do
      Link.create!(url: params[:url], shortened_url: generate_shortened_url)
    end
  end

  private

  def valid?
    params.fetch(:url, '').match?(URL_REGEX)
  end

  def generate_shortened_url
    SecureRandom.uuid[-5..-1]
  end
end
