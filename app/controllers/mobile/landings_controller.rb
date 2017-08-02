class Mobile::LandingsController < MobileController

  def show
    @campaing_landing = CampaingLanding.find_by_vanity_url(params[:slug])
  end

	def fenty
    @campaing = Popup.find_by_campaing("fenty-beauty")
  end

  def beautyfair; end
  def masterclass; end
  def oasis; end
  def brow_collection; end
  def bellezaparallevar; end
  def beautyclasses; end
  def promocionessephora; end
  def regalaconamor; end
  def monterrey; end
  def smashboxcovershotpalette; end
  def promociondiadelasmadres; end
end
