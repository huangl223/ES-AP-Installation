note
	description: "[
		An interface for describing a event in a system.
		
		The default implementation for this interface is {EVENT_TYPE}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: 2015-12-17 13:34:17 +0000 (Thu, 17 Dec 2015) $";
	revision: "$Revision: 98279 $"

deferred class
	EVENT_TYPE_I [EVENT_DATA -> TUPLE]

inherit
	USABLE_I

	DISPOSABLE_I

feature -- Status report

	is_subscribed (a_action: PROCEDURE [EVENT_DATA]): BOOLEAN
			-- Determines if the event already has a subscription for a specified action.
			--
			-- `a_action': An action to check an existing subscription for
			-- `Result': True if the action is already subscribed, False otherwise.
		require
			a_action_attached: a_action /= Void
		deferred
		ensure
			not_is_subscribed: not is_interface_usable implies not Result
		end

	is_suspended: BOOLEAN
			-- Is the publication of all actions from the subscription list suspended?
			-- (Answer: no by default.)	
		deferred
		end

feature -- Status settings

	suspend_subscriptions
			-- Ignore the call of all actions from the subscription list,
			-- until feature `restore_subscription' is called.
			--
			-- Note: Suspension is based on a stacked number of calls. 3 calls to `suspend_subscription'
			--       must be match with 3 calls to `restore_subscription' for publication to occur.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			subscription_suspended: is_suspended
		end

	restore_subscriptions
			-- Consider again the call of all actions from the subscription list,
			-- until feature `suspend_subscription' is called.
			--
			-- Note: see `suspend_subscription' for information on stacked suspension.
		require
			is_suspended: is_suspended
		deferred
		end

feature -- Subscription

	subscribe (a_action: PROCEDURE [EVENT_DATA])
			-- Subscribes an action to the event.
			--
			-- `a_action': The action to subscribe.
		require
			is_interface_usable: is_interface_usable
			a_action_attached: a_action /= Void
			not_a_action_is_subscribed: not is_subscribed (a_action)
		deferred
		ensure
			a_action_subscribed: is_subscribed (a_action)
		end

	subscribe_for_single_notification (a_action: PROCEDURE [EVENT_DATA])
			-- Subscribes an action to the event for a single publication only.
			--
			-- `a_action': The action to subscribe.
		require
			is_interface_usable: is_interface_usable
			a_action_attached: a_action /= Void
			not_a_action_is_subscribed: not is_subscribed (a_action)
		deferred
		ensure
			a_action_subscribed: is_subscribed (a_action)
		end

	unsubscribe (a_action: PROCEDURE [EVENT_DATA])
			-- Unsubscribes an action from the event.
			-- Note: If a_action_is_subscribed fails then Freeze, you're could be comparing melted and
			--       frozen agents which are not equal objects.
			--
			-- `a_action': A previously subscribed action to unsubscribe.
		require
			is_interface_usable: is_interface_usable
			a_action_attached: a_action /= Void
			a_action_is_subscribed: is_subscribed (a_action)
		deferred
		ensure
			a_action_unsubscribed: not is_subscribed (a_action)
		end

feature -- Basic operations

	perform_suspended_action (a_action: PROCEDURE)
			-- Performs a action whilst suspending subscriptions from receive a publication
			--
			-- `a_action': Action to call while the event is suspended.
		require
			is_interface_usable: is_interface_usable
			a_action_attached: a_action /= Void
		local
			l_suspended: BOOLEAN
		do
			suspend_subscriptions
			l_suspended := True
			a_action.call (Void)
			restore_subscriptions
		ensure
			is_suspended_unchanged: is_suspended = old is_suspended
		rescue
			if l_suspended then
					-- In case call raises and exception, restore the subscription
				restore_subscriptions
			end
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
